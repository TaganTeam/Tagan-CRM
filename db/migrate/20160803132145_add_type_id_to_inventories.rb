class AddTypeIdToInventories < ActiveRecord::Migration
  def change
    add_column(:inventories,:type_id, :integer)
  end
end
