class ChangeColumnInBookCategories < ActiveRecord::Migration[7.2]
  def change
    add_index :book_categories, [:book_id, :category_id], unique: true
  end
end
