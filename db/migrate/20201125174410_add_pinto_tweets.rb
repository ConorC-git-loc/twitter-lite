class AddPintoTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :pin, :boolean, null: false, default: false
  end
end
