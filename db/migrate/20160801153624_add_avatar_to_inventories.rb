class AddAvatarToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :avatar, :string
  end
end
