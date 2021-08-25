# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, %i[follower_id followed_id], unique: true
    add_index :relationships, :followed_id
  end
end
