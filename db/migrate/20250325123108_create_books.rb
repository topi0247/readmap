class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :uri
      t.string :isbn

      t.timestamps
    end
  end
end
