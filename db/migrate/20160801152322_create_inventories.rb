class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :user_id
      t.integer :inventory_id
      t.date    :receipt_date

      t.timestamps null: false
    end
  end
end
