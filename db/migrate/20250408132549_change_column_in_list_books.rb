class ChangeColumnInListBooks < ActiveRecord::Migration[7.2]
  def change
    change_column_null(:list_books, :read_completed_at, false)
    add_index :list_books, [:list_id, :book_id], unique: true
  end
end
