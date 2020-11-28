class Tweet < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  belongs_to :source_tweet, optional: true, inverse_of: :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'
  has_many :retweets, inverse_of: :source_tweet, class_name: 'Tweet', foreign_key: 'retweet_id', dependent: :destroy

  has_rich_text :body

  validates :body, presence: true, unless: :retweet_id?


  scope :pin,  -> { where(pin: true) }
  scope :no_pin, ->(id) { where.not(id: id) if id }

  after_save :ensure_only_one_pinned_tweet


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

  def source_tweet_id
    if source_tweet
      source_tweet.id
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

  private

  def ensure_only_one_pinned_tweet
    user.tweets.pin.no_pin(id).update_all(pin: false) if pin?
  end


end
