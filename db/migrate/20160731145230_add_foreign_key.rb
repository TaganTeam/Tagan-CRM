class AddForeignKey < ActiveRecord::Migration
  def change
    add_foreign_key :technologies, :users, on_delete: :cascade
  end
end
