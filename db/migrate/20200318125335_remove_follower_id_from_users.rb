class RemoveFollowerIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :follower_id, :integer
  end
end
