class AddIndexToRelationshipsFollowedId < ActiveRecord::Migration[6.1]
  def change
    add_index :relationships, :followed_id, unique: true
  end
end
