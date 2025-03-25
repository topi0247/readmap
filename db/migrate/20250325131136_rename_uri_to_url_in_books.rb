class RenameUriToUrlInBooks < ActiveRecord::Migration[7.2]
  def change
    rename_column :books, :uri, :url
  end
end
