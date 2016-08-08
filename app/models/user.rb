class User < ActiveRecord::Base
  has_many :technologies, dependent: :destroy
  accepts_nested_attributes_for :technologies, allow_destroy: true
  validate :valid_date?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable


  before_save :ensure_authentication_token
  acts_as_api

  enum role: [:admin, :management, :developers, :trainees]
  enum status: [:offline, :online, :away]

  api_accessible :basic do |t|
    t.add :id
    t.add :email
    t.add :role
    t.add :full_name
    t.add :status
    t.add :created_at
  end

  api_accessible :default_token, extend: :basic do |t|
    t.add :authentication_token, as: :access_token
  end

  api_accessible :my_profile_mode, extend: :default_token do |t|
    t.add :id
    t.add :sign_in_count
    t.add :current_sign_in_at
    t.add :current_sign_in_ip
    t.add :confirmed_at
  end

  class << self
    def authenticate(email_or_username, password)
      user = User.where(["lower(email) = :value", { :value => email_or_username.downcase }]).first

      return nil unless user
      unless user.valid_password?(password)
        sign_in_attributes = {
            failed_attempts: user.failed_attempts.to_i + 1
        }
        user.update_columns(sign_in_attributes)
        user.lock_access! if user.failed_attempts >= Devise.maximum_attempts
        return nil
      end

        user.unlock_access! if user.access_locked? && user.locked_at < Devise.unlock_in.ago
        user

    end

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end

  def validate_request!(request, params)
    if access_locked?
      errors.add(:account,'is locked please contact us')
    # elsif !confirmed?
    #   errors.add(:email,'is not confirmed yet')
    elsif timedout?(current_sign_in_at)
      errors.add(:session, 'expired. Please make re-login.')
    else
      sign_in_attributes = {
          current_sign_in_ip: request.env['REMOTE_ADDR'],
          current_sign_in_at: DateTime.now,
          last_sign_in_at: DateTime.now,
          last_sign_in_ip: request.env['REMOTE_ADDR'],
          sign_in_count:   (sign_in_count.to_i + 1)
      }

      update_columns(sign_in_attributes)
    end
  end

  def full_name
    "#{self.first_name} #{self.patronumic} #{self.last_name}"
  end



  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end


  def valid_date?
    unless self.birthday == nil
      if self.birthday > Date.today
        errors.add(:birthday, "is missing or invalid")
      end
    end
  end

end
