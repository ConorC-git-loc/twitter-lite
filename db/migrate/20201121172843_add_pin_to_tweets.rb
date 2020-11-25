class AddPinToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :pin, :boolean
  end
end
