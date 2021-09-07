class RemoveImageableFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_reference :comments, :imageable
    add_belongs_to :comments, :commentable, null: false, polymorphic: true
  end
end
