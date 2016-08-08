class Technology < ActiveRecord::Base
  belongs_to :user
  # acts_as_api
  #
  # api_accessible :basic do |t|
  #   t.add :id
  #   t.add :title
  #   t.add :comment
  #   t.add :user_id
  # end
end
