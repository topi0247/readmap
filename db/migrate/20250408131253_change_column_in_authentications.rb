class ChangeColumnInAuthentications < ActiveRecord::Migration[7.2]
  def change
    change_column_null(:authentications, :email, false)
    change_column_null(:authentications, :provider, false)
  end
end
