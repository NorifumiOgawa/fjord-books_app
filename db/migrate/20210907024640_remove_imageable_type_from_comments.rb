class RemoveImageableTypeFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :imageable_type, :string
  end
end
