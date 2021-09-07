class ChangeNotnullToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :user_id, false
    change_column_null :comments, :body, false
    add_index :comments, :user_id
  end
end
