class ChangeColumnInLists < ActiveRecord::Migration[7.2]
  def change
    change_column_null(:lists, :name, false)
    change_column_null(:lists, :is_public, false)
    change_column_default(:lists, :is_public, true)
  end
end
