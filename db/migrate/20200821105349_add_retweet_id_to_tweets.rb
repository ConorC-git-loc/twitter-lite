class AddRetweetIdToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :retweet_id, :int
  end
end
