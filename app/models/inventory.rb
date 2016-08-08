class Inventory < ActiveRecord::Base
  belongs_to :type
  belongs_to :user
  # mount_uploader :avatar, AvatarUploader

  acts_as_api

  api_accessible :basic do |t|
    t.add :id
    t.add :user, template: :basic
    t.add :receipt_date
    t.add :inventory_id
    t.add lambda{ |inventory| inventory.avatar.url rescue nil }, as: :image
    t.add :type, template: :basic
  end
end
