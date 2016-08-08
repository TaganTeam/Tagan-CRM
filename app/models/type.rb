class Type < ActiveRecord::Base
  has_one :inventory, foreign_key: :type_id

  acts_as_api

  api_accessible :basic do |t|
    t.add :id
    t.add :name
  end
end