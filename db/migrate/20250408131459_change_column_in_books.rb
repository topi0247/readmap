class ChangeColumnInBooks < ActiveRecord::Migration[7.2]
  def change
    change_column_null(:books, :title, false)
    change_column_null(:books, :url, false)
    change_column_null(:books, :isbn, false)
    add_index :books, [:url, :isbn], length: 255, unique: true
  end
end
