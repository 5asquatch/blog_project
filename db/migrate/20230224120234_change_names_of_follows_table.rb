class ChangeNamesOfFollowsTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :follows, :followed_user_id, :followee_id
  end
end
