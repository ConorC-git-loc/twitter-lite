class Tweet < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  belongs_to :source_tweet, optional: true, inverse_of: :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'
  has_many :retweets, inverse_of: :source_tweet, class_name: 'Tweet', foreign_key: 'retweet_id'

  validates :content, presence: true, unless: :retweet_id?, length: { maximum: 255 }

  

  def content
    if source_tweet
      source_tweet.content
    else
      super
    end
  end

  def content=(content)
    if source_tweet
      raise 'retweets cannot have content'
    else
      super
    end
  end

  def username
  	if source_tweet
  	  source_tweet.user.username
  	else
  	  super
  	end
  end

  def retweet_count
  	if source_tweet
  	  source_tweet.retweets.count
  	else
  	  super
  	end
  end

  def source_user_id
  	if source_tweet
  	  source_tweet.user_id
  	else
  	  super
  	end
  end

end


