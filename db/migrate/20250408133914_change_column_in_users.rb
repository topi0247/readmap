class ChangeColumnInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_null(:users, :name, false)
    change_column_null(:users, :is_public, false)
    change_column_default(:users, :is_public, true)
  end
end
