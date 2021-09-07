class AddUserRefToReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :user_id, :integer
    add_belongs_to :reports, :user, null: false, foreign_key: true
  end
end
