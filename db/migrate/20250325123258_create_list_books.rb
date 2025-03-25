class CreateListBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :list_books do |t|
      t.references :list, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :read_completed_at
      t.text :comment

      t.timestamps
    end
  end
end
