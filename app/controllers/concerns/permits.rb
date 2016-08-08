module Permits
  USER = [
      :id,
      :email,
      :username,
      :role_id,
      :password,
      :password_confirmation
  ]

  CAR = [
      :id,
      :name,
      :is_stock,
      :max_speed,
      :price,
      :users_id
  ]

  def self.controller(name)
    self.send name.gsub(/\W/,'_').singularize.downcase.gsub('manage_','')
  end

  def self.user
    USER.dup
  end

  def self.car
    CAR.dup
  end
end