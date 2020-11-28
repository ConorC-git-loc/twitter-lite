module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

  def tweeted_num_text(_counted_tweets)
    result = "<b>#{current_user.tweets.count}</b> Tweet"
    result += 's' if current_user.tweets.count > 1 || current_user.tweets.count == 0
    result.html_safe
  end

  def reply_count(_reply_counts)
    if tweet.comments.count == 1
      tweet.comments.count Reply
    else
      tweet.comments.count Replies
    end
  end

  # link_to helpers

  def update_pin(tweet)
    if tweet.pin == false
      link_to 'Pin to your profile', pin_tweet_path(tweet), method: :patch, class: 'dropdown-item'
    else
      link_to 'Unpin', unpin_tweet_path(tweet), method: :patch, class: 'dropdown-item'
    end
  end
  
  def follow_link(tweet)
    if current_user.id != tweet.user.id 
      if current_user.following?(tweet.user)
        link_to "Unfollow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :delete }, :id => "unfollowed", :class => "follow dropdown-item" 
      else 
         link_to "Follow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :post }, :class => "follow dropdown-item" 
      end
    end
  end

              
            

  # Avatar helpers

  def index_avatar(_index_image)
    if current_user.avatar.attached?
      image_tag current_user.avatar.variant(resize: '150x150!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 100, width: 100, class: 'rounded-circle'
    end
  end

  def sidebar_avatar(_sidebar)
    if current_user.avatar.attached?
      image_tag current_user.avatar.variant(resize: '60x60!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 100, width: 100, class: 'rounded-circle'
    end
  end

  def registration_avatar(_registration_image)
    if resource.avatar.attached?
      image_tag resource.avatar.variant(resize: '100x100!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 100, width: 100, class: 'rounded-circle'
    end
  end

  def avatar_profile_page(_image_small)
    if @user.avatar.attached?
      image_tag @user.avatar.variant(resize: '100x100!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 100, width: 100, class: 'rounded-circle'
    end
  end

  def retweets_index_avatar(tweet)
    if tweet.source_tweet.user.avatar.attached?
      image_tag tweet.source_tweet.user.avatar.variant(resize: '50x50!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 50, width: 50, class: 'rounded-circle'
    end
  end

  def tweets_index_avatar(tweet)
    if tweet.user.avatar.attached?
      image_tag tweet.user.avatar.variant(resize: '50x50!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 50, width: 50, class: 'rounded-circle'
    end
  end

  def latest_tweets_login(tweet)
    if tweet.user.avatar.attached?
      image_tag tweet.user.avatar.variant(resize: '30x30!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 30, width: 30, class: 'rounded-circle'
    end
  end

  def member_list_avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(resize: '30x30!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 30, width: 30, class: 'rounded-circle'
    end
  end

  def follower_list_avatar(follower)
    if follower.avatar.attached?
      image_tag follower.avatar.variant(resize: '60x60!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 60, width: 60, class: 'rounded-circle'
    end
  end

  def following_list_avatar(following)
    if following.avatar.attached?
      image_tag following.avatar.variant(resize: '30x30!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 30, width: 30, class: 'rounded-circle'
    end
  end

  def follower_small_avatar(follower)
    if follower.avatar.attached?
      image_tag follower.avatar.variant(resize: '30x30!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 30, width: 30, class: 'rounded-circle'
    end
  end

  def comment_avatar(comment)
    if comment.user.avatar.attached?
      image_tag comment.user.avatar.variant(resize: '20x20!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 20, width: 20, class: 'rounded-circle'
    end
  end

  def tweet_list_avatar(user)
    if user.avatar.attached?
      image_tag user.avatar.variant(resize: '50x50!'), class: 'rounded-circle'
    else
      image_tag 'default_avatar.jpg', height: 30, width: 30, class: 'rounded-circle'
    end
  end
end
