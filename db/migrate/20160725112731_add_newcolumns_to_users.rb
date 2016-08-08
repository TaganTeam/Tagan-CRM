class AddNewcolumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :patronumic, :string
    add_column :users, :birthday, :date
    add_column :users, :city_of_birth, :string
    add_column :users, :city_of_residence, :string
  end
end
