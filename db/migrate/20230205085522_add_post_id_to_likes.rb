class AddPostIdToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :post_id, :int
    add_column :likes, :user_id, :int
  end
end
