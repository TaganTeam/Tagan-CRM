class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.integer :user_id
      t.string :title
      t.string :comment

      t.timestamps null: false
    end
  end
end
