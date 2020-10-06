<%= form_for(current_user.active_relationships.find_by(followed_id: tweet.user), html: { method: :delete }) do |f| %>
    <%= f.submit "Unfollow", class: "btn btn-primary" %>

    <div class="col-lg-6"></div>

    <%= render partial: '/shared/tweets', collection: @tweets, as: :tweet %>

    <div class="form-group">
                <div class ="row">
                  <div class = "col-sm-4">
                    <%= if resource.avatar.attached? %>
                      <%= image_tag resource.avatar.variant(resize: "100x100!"), class: "rounded-circle" %>
                    <% else%>
                      <%= image_tag gravatar_image_url(current_user.email, size: 100), height: 100, width: 100, class: "rounded-circle" %>
                    <% end %>
                  </div>
                  <div class="col-sm-8">
                    <%= f.file_field :avatar %>
                  </div>
                </div>
    </div>


    $ ->
    if $('.pagination').length && $('#tweets').length
      $(window).scroll ->
        url = $('.pagination .next_page').attr('href')
        if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
          $('.pagination').text("Loading more tweets...")
          $.getScript(url)
      $(window).scroll

      $(document).ready(function() {
  if ($('#infinite-scrolling').length > 0) {
    return $(window).on('scroll', function() {
      var more_tweets_url; 
      more_tweets_url = $('.pagination .next_page').attr('href');
      if (more_tweets_url && $(window).scrollTop() > $(document).height() - $(window).height() - 250) {
        $('.pagination').html('<b>Loading moore Tweets...</b>');
        $.getScript(more_tweets_url);
      }
      return;
    });
  }
});


<div id="comments">
          <div class="indent-right">
            <% tweet.comments.reverse.each do |comment| %>
            <div class="row">
              <div class="col-1">
                <%= tweets_index_avatar(tweet) %>
              </div>
              <div class="col-8">
                <p class="text-small" style="padding-left: 30px">
                  <b><%= comment.user.username %></b>&nbsp;&nbsp;@<%= comment.user.handle %>
                  <br>
                  Replying to @<%= link_to comment.tweet.user.handle, thisuser_path(tweet.user_id) %>
                  <br>
                  <br>
                  <%= comment.body %>
                  <br>
                  <br>
                  Replied <%= time_ago_in_words(comment.created_at) %> ago
                  <hr />
                </p>
              </div>
            </div>
            <% end %>
        </div>
      </div>


      <button type="button" class="btn btn-sm btn-primary rounded-pill" data-toggle="modal" data-target="#exampleModalCenter#<%= tweet.id %>">
                  <i class="fas fa-comment-dots"></i>
                </button>










<div class="tweet-display top-margin" id="tweets">
  <div class="scrollable scrollbar-light-blue">
      <% @tweets.each do |tweet| %>
      <div class="block">
        <a class="overlay" href="<%= tweet_path(tweet.id) %>"></a>
        <div class="inner">
        <p class="tweet_right_options tweet_break">
          <% if current_user.id != tweet.user.id %> 
            <% if current_user.following?(tweet.user) %>
                <%= link_to "Unfollow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :delete }, :class => "follow-btn btn btn-sm btn-outline-primary rounded-pill" %>
              <% else %>
                <%= link_to "Follow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :post }, :class => "follow-btn btn btn-sm btn-outline-primary rounded-pill" %>
            <% end %>
            <br>
          <% end %>
        </p>

        <br>
        <div class="row">
          <div class="col-1">
            <%= tweets_index_avatar(tweet) %>
          </div>
          <div class="col-10">
              @<%= tweet.user.handle %>&nbsp;&nbsp;<strong><%= link_to tweet.user.username, thisuser_path(tweet.user_id) %></strong>&nbsp;&nbsp;<div class="text-inline-tweet"><%= time_ago_in_words(tweet.created_at) %></div>
            <br>
            <br>
            <p><%= tweet.content %></p>
            <br>
            <% if tweet.retweet_id? %>
              <p class="text-small small-text-grey">Retweeted
                <%= link_to thisuser_path(tweet.source_user_id) do %>
                  @<%= tweet.username %><% end %><%= tweet.retweet_count %>
                <% end %>
              </p>
            <br>
          

            <!-- like buttons -->
            <div class="row">
              <div class="col-2 small-text-grey">
                
                <% pre_like = tweet.likes.find { |like| like.user_id == current_user.id} %>
                  <% if pre_like %>
                    <%= link_to '<i class="far fa-thumbs-up"></i>'.html_safe, tweet_like_path(tweet, pre_like), data: { remote: true, type: :json, method: :delete }, :class => "like-btn btn btn-primary btn-sm rounded-pill" %>
                  <% else %>
                    <%= link_to '<i class="fas fa-thumbs-up"></i>'.html_safe, tweet_likes_path(tweet), data: { remote: true, type: :json, method: :post }, :class => "like-btn btn btn-primary btn-sm rounded-pill" %>
                  <% end %>
                  &nbsp;&nbsp;<%= tweet.likes.count %>
              </div> 

              
              <div class="col-2 small-text-grey">
              <%= link_to '<i class="fas fa-comment-dots"></i>'.html_safe, tweet_path(tweet.id), :class => 'btn btn-sm btn-primary rounded-pill', data: {toggle: "modal", target: "#exampleModalCenter#<%= tweet.id %>"}  %>
                &nbsp;&nbsp;<%= tweet.comments.count %><%= link_to 'Show', tweet_path(tweet.id) %>
              </div>


              <div class="col-2 small-text-grey">
              <%= link_to '<i class="fas fa-retweet"></i>'.html_safe, retweet_tweet_path(tweet.id), class: "btn btn-sm btn-primary rounded-pill", method: :post %>&nbsp;&nbsp;<%= tweet.retweets.count %>
              </div>
            </div>
                
            <br>
          </div>
        </div>
    </div>
      </div>
      

      <!-- place in partial -->

<!-- Modal -->
        <div class="modal fade" id="exampleModalCenter#<%= tweet.id %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <h5 class="modal-title tweet-modal-text" id="exampleModalLongTitle"><%= tweets_index_avatar(tweet) %>&nbsp;&nbsp;<%= tweet.user.username %></h5>
                <p class= "tweet-modal-text"><%= tweet.content %></p>
                <button type="button" class="close tweet_right_options" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              <div class="modal-body">
                <div class="text-center">
                <%= simple_form_for [tweet, @comment] do |f| %>
                  <%= f.text_area :body, :rows => 5, style: 'width:70%;' %><br>
                  <%= f.submit "Reply", class: "btn btn-sm btn-primary" %>
                <% end %>
                </div>
              </div>
            </div>
          </div>
        </div>


         <!-- comments -->
        
        <hr/>
      <% end %>

    <div id="infinite-scrolling">
      <%= will_paginate @tweets, :param_name => 'tweets_page' %>
    </div>

  </div>
  </div>
</div>


<div class="col-2 small-text-grey">
              <button type="button" class="btn btn-sm btn-primary rounded-pill" data-toggle="modal" data-target="#exampleModalCenter#<%= tweet.id %>">
                  <i class="fas fa-comment-dots"></i>
                </button>
                &nbsp;&nbsp;<%= tweet.comments.count %><%= link_to 'Show', tweet_path(tweet.id) %>
              </div>