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


<div class="col-lg-6">
  <%= render partial: '/shared/chart1' %>
  <hr />
  <%= render partial: 'follower' %>
  <hr />
  <%= render partial: 'following' %>
  <hr />
</div>

<div class="col-1">
              <% unless tweet.source_tweet.retweet_id.blank? || tweet.user_id == current_user.id %>
                <%= link_to '<i class="fas fa-retweet"></i>'.html_safe, retweet_tweet_path(tweet.source_tweet_id), class: "retweet-index btn btn-sm btn-primary rounded-pill", method: :post %>&nbsp;&nbsp;<%= tweet.source_tweet.retweets.count %>
              <% else %>
              <div class="retweet-index btn btn-sm btn-retweeted rounded-pill">
                 <i class="fas fa-retweet"></i>
              </div>
               &nbsp;&nbsp;<%= tweet.source_tweet.retweets.count %>
              <% end %>
            </div>



//
// Provides a drop-in pointer for the default Trix stylesheet that will format the toolbar and
// the trix-editor content (whether displayed or under editing). Feel free to incorporate this
// inclusion directly in any other asset bundle and remove this file.
//
//= require trix/dist/trix

// We need to override trix.css’s image gallery styles to accommodate the
// <action-text-attachment> element we wrap around attachments. Otherwise,
// images in galleries will be squished by the max-width: 33%; rule.


.trix-content {
  .attachment-gallery {
    > action-text-attachment,
    > .attachment {
      flex: 1 0 33%;
      padding: 0 0.5em;
      max-width: 33%;
    }

    &.attachment-gallery--2,
    &.attachment-gallery--4 {
      > action-text-attachment,
      > .attachment {
        flex-basis: 50%;
        max-width: 50%;
      }
    }
  }

  action-text-attachment {
    .attachment {
      max-width: 80px;
    }
  }
}


@charset "UTF-8";
/*
Trix 1.3.0
Copyright © 2020 Basecamp, LLC
http://trix-editor.org/*/
trix-editor {
  border: none;
  text-align: left;
  border-radius: 3px;
  margin: 0;
  padding: 0.4em 0.6em;
  min-height: 5em;
  outline: none; }
trix-toolbar * {
  box-sizing: border-box; }
trix-toolbar .trix-button-row {
  display: flex;
  flex-wrap: nowrap;
  justify-content: space-between;
  overflow-x: auto; }
trix-toolbar .trix-button-group {
  display: flex;
  margin-bottom: 10px;
  border: none;
  border-top-color: #fff;
  border-bottom-color: #fff;
  border-radius: 0px; }
  trix-toolbar .trix-button-group:not(:first-child) {
    margin-left: 0; }
    @media (max-device-width: 768px) {
      trix-toolbar .trix-button-group:not(:first-child) {
        margin-left: 0; } }
trix-toolbar .trix-button-group-spacer {
  flex-grow: 1; }
  @media (max-device-width: 768px) {
    trix-toolbar .trix-button-group-spacer {
      display: none; } }
trix-toolbar .trix-button {
  position: relative;
  float: left;
  color: #007bff;
  font-size: 0.75em;
  font-weight: 600;
  white-space: nowrap;
  padding: 0 0.5em;
  margin: 0;
  outline: none;
  border: none;
  border-bottom: 0px;
  border-radius: 0;
  background: transparent; }
  trix-toolbar .trix-button:not(:first-child) {
    border-left: 0px solid #ccc; }
  trix-toolbar .trix-button.trix-active {
    background: #fff;
    color: #007bff; }
  trix-toolbar .trix-button:not(:disabled) {
    cursor: pointer; }
  trix-toolbar .trix-button:disabled {
    color: #007bff; }
  @media (max-device-width: 768px) {
    trix-toolbar .trix-button {
      letter-spacing: -0.01em;
      padding: 0 0.3em; } }
trix-toolbar .trix-button--icon {
  font-size: inherit;
  width: 2.6em;
  height: 1.6em;
  max-width: calc(0.8em + 4vw);
  text-indent: -9999px; }
  @media (max-device-width: 768px) {
    trix-toolbar .trix-button--icon {
      height: 2em;
      max-width: calc(0.8em + 3.5vw); } }
  trix-toolbar .trix-button--icon::before {
    display: inline-block;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    opacity: 0.6;
    content: "";
    background-position: center;
    background-repeat: no-repeat;
    background-size: contain; }
    @media (max-device-width: 768px) {
      trix-toolbar .trix-button--icon::before {
        right: 6%;
        left: 6%; } }
  trix-toolbar .trix-button--icon.trix-active::before {
    opacity: 1; }
  trix-toolbar .trix-button--icon:disabled::before {
    opacity: 0.125; }
trix-toolbar .trix-button--icon-attach::before {
  background-image: url(paperclip-solid.svg);
  top: 8%;
  bottom: 4%; }
trix-toolbar .trix-button--icon-bold::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M15.6%2011.8c1-.7%201.6-1.8%201.6-2.8a4%204%200%200%200-4-4H7v14h7c2.1%200%203.7-1.7%203.7-3.8%200-1.5-.8-2.8-2.1-3.4zM10%207.5h3a1.5%201.5%200%201%201%200%203h-3v-3zm3.5%209H10v-3h3.5a1.5%201.5%200%201%201%200%203z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-italic::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M10%205v3h2.2l-3.4%208H6v3h8v-3h-2.2l3.4-8H18V5h-8z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-link::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M9.88%2013.7a4.3%204.3%200%200%201%200-6.07l3.37-3.37a4.26%204.26%200%200%201%206.07%200%204.3%204.3%200%200%201%200%206.06l-1.96%201.72a.91.91%200%201%201-1.3-1.3l1.97-1.71a2.46%202.46%200%200%200-3.48-3.48l-3.38%203.37a2.46%202.46%200%200%200%200%203.48.91.91%200%201%201-1.3%201.3z%22%2F%3E%3Cpath%20d%3D%22M4.25%2019.46a4.3%204.3%200%200%201%200-6.07l1.93-1.9a.91.91%200%201%201%201.3%201.3l-1.93%201.9a2.46%202.46%200%200%200%203.48%203.48l3.37-3.38c.96-.96.96-2.52%200-3.48a.91.91%200%201%201%201.3-1.3%204.3%204.3%200%200%201%200%206.07l-3.38%203.38a4.26%204.26%200%200%201-6.07%200z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-strike::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M12.73%2014l.28.14c.26.15.45.3.57.44.12.14.18.3.18.5%200%20.3-.15.56-.44.75-.3.2-.76.3-1.39.3A13.52%2013.52%200%200%201%207%2014.95v3.37a10.64%2010.64%200%200%200%204.84.88c1.26%200%202.35-.19%203.28-.56.93-.37%201.64-.9%202.14-1.57s.74-1.45.74-2.32c0-.26-.02-.51-.06-.75h-5.21zm-5.5-4c-.08-.34-.12-.7-.12-1.1%200-1.29.52-2.3%201.58-3.02%201.05-.72%202.5-1.08%204.34-1.08%201.62%200%203.28.34%204.97%201l-1.3%202.93c-1.47-.6-2.73-.9-3.8-.9-.55%200-.96.08-1.2.26-.26.17-.38.38-.38.64%200%20.27.16.52.48.74.17.12.53.3%201.05.53H7.23zM3%2013h18v-2H3v2z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-quote::before {
  background-image: url(data:image/svg+xml,%3Csvg%20version%3D%221%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M6%2017h3l2-4V7H5v6h3zm8%200h3l2-4V7h-6v6h3z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-heading-1::before {
  background-image: url(data:image/svg+xml,%3Csvg%20version%3D%221%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M12%209v3H9v7H6v-7H3V9h9zM8%204h14v3h-6v12h-3V7H8V4z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-code::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M18.2%2012L15%2015.2l1.4%201.4L21%2012l-4.6-4.6L15%208.8l3.2%203.2zM5.8%2012L9%208.8%207.6%207.4%203%2012l4.6%204.6L9%2015.2%205.8%2012z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-bullet-list::before {
  background-image: url(data:image/svg+xml,%3Csvg%20version%3D%221%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M4%204a2%202%200%201%200%200%204%202%202%200%200%200%200-4zm0%206a2%202%200%201%200%200%204%202%202%200%200%200%200-4zm0%206a2%202%200%201%200%200%204%202%202%200%200%200%200-4zm4%203h14v-2H8v2zm0-6h14v-2H8v2zm0-8v2h14V5H8z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-number-list::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M2%2017h2v.5H3v1h1v.5H2v1h3v-4H2v1zm1-9h1V4H2v1h1v3zm-1%203h1.8L2%2013.1v.9h3v-1H3.2L5%2010.9V10H2v1zm5-6v2h14V5H7zm0%2014h14v-2H7v2zm0-6h14v-2H7v2z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-undo::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M12.5%208c-2.6%200-5%201-6.9%202.6L2%207v9h9l-3.6-3.6A8%208%200%200%201%2020%2016l2.4-.8a10.5%2010.5%200%200%200-10-7.2z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-redo::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M18.4%2010.6a10.5%2010.5%200%200%200-16.9%204.6L4%2016a8%208%200%200%201%2012.7-3.6L13%2016h9V7l-3.6%203.6z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-decrease-nesting-level::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M3%2019h19v-2H3v2zm7-6h12v-2H10v2zm-8.3-.3l2.8%202.9L6%2014.2%204%2012l2-2-1.4-1.5L1%2012l.7.7zM3%205v2h19V5H3z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-button--icon-increase-nesting-level::before {
  background-image: url(data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%3E%3Cpath%20d%3D%22M3%2019h19v-2H3v2zm7-6h12v-2H10v2zm-6.9-1L1%2014.2l1.4%201.4L6%2012l-.7-.7-2.8-2.8L1%209.9%203.1%2012zM3%205v2h19V5H3z%22%2F%3E%3C%2Fsvg%3E); }
trix-toolbar .trix-dialogs {
  position: relative; }
trix-toolbar .trix-dialog {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  font-size: 0.75em;
  padding: 15px 10px;
  background: #fff;
  box-shadow: 0 0.3em 1em #ccc;
  border-top: 2px solid #888;
  border-radius: 5px;
  z-index: 5; }
trix-toolbar .trix-input--dialog {
  font-size: inherit;
  font-weight: normal;
  padding: 0.5em 0.8em;
  margin: 0 10px 0 0;
  border-radius: 3px;
  border: 1px solid #bbb;
  background-color: #fff;
  box-shadow: none;
  outline: none;
  -webkit-appearance: none;
  -moz-appearance: none; }
  trix-toolbar .trix-input--dialog.validate:invalid {
    box-shadow: #F00 0px 0px 1.5px 1px; }
trix-toolbar .trix-button--dialog {
  font-size: inherit;
  padding: 0.5em;
  border-bottom: none; }
trix-toolbar .trix-dialog--link {
  max-width: 600px; }
trix-toolbar .trix-dialog__link-fields {
  display: flex;
  align-items: baseline; }
  trix-toolbar .trix-dialog__link-fields .trix-input {
    flex: 1; }
  trix-toolbar .trix-dialog__link-fields .trix-button-group {
    flex: 0 0 content;
    margin: 0; }
trix-editor [data-trix-mutable]:not(.attachment__caption-editor) {
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none; }

trix-editor [data-trix-mutable]::-moz-selection,
trix-editor [data-trix-cursor-target]::-moz-selection, trix-editor [data-trix-mutable] ::-moz-selection {
  background: none; }
trix-editor [data-trix-mutable]::selection,
trix-editor [data-trix-cursor-target]::selection, trix-editor [data-trix-mutable] ::selection {
  background: none; }

trix-editor [data-trix-mutable].attachment__caption-editor:focus::-moz-selection {
  background: highlight; }
trix-editor [data-trix-mutable].attachment__caption-editor:focus::selection {
  background: highlight; }

trix-editor [data-trix-mutable].attachment.attachment--file {
  box-shadow: 0 0 0 2px highlight;
  border-color: transparent; }
trix-editor [data-trix-mutable].attachment img {
  box-shadow: 0 0 0 2px highlight; }
trix-editor .attachment {
  position: left; }
  trix-editor .attachment:hover {
    cursor: default; }
trix-editor .attachment--preview .attachment__caption:hover {
  cursor: text; }
trix-editor .attachment__progress {
  position: absolute;
  z-index: 1;
  height: 20px;
  top: calc(50% - 10px);
  left: 5%;
  width: 90%;
  opacity: 0.9;
  transition: opacity 200ms ease-in; }
  trix-editor .attachment__progress[value="100"] {
    opacity: 0; }
trix-editor .attachment__caption-editor {
  display: inline-block;
  width: 100%;
  margin: 0;
  padding: 0;
  font-size: inherit;
  font-family: inherit;
  line-height: inherit;
  color: #007bff;
  text-align: left;
  vertical-align: top;
  border: none;
  outline: none;
  -webkit-appearance: none;
  -moz-appearance: none; }
trix-editor .attachment__toolbar {
  position: absolute;
  z-index: 1;
  top: -0.9em;
  left: 0;
  width: 100%;
  text-align: left; }
trix-editor .trix-button-group {
  display: inline-flex; }
trix-editor .trix-button {
  position: relative;
  float: left;
  color: #666;
  white-space: nowrap;
  font-size: 80%;
  padding: 0 0.8em;
  margin: 0;
  outline: none;
  border: none;
  border-radius: 0;
  background: transparent; }
  trix-editor .trix-button:not(:first-child) {
    border-left: 1px solid #ccc; }
  trix-editor .trix-button.trix-active {
    background: #cbeefa; }
  trix-editor .trix-button:not(:disabled) {
    cursor: pointer; }
trix-editor .trix-button--remove {
  text-indent: -9999px;
  display: inline-block;
  padding: 0;
  outline: none;
  width: 1.8em;
  height: 1.8em;
  line-height: 1.8em;
  border-radius: 50%;
  background-color: #007bff;
  border: 2px solid highlight;
  box-shadow: 1px 1px 6px rgba(0, 0, 0, 0.25); }
  trix-editor .trix-button--remove::before {
    display: inline-block;
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    opacity: 0.7;
    content: "";
    background-image: url(data:image/svg+xml,%3Csvg%20height%3D%2224%22%20width%3D%2224%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Cpath%20d%3D%22M19%206.4L17.6%205%2012%2010.6%206.4%205%205%206.4l5.6%205.6L5%2017.6%206.4%2019l5.6-5.6%205.6%205.6%201.4-1.4-5.6-5.6z%22%2F%3E%3Cpath%20d%3D%22M0%200h24v24H0z%22%20fill%3D%22none%22%2F%3E%3C%2Fsvg%3E);
    background-position: center;
    background-repeat: no-repeat;
    background-size: 90%; }
  trix-editor .trix-button--remove:hover {
    border-color: #333; }
    trix-editor .trix-button--remove:hover::before {
      opacity: 1; }
trix-editor .attachment__metadata-container {
  position: relative; }
trix-editor .attachment__metadata {
  position: absolute;
  left: 50%;
  top: 2em;
  transform: translate(-50%, 0);
  max-width: 90%;
  padding: 0.1em 0.6em;
  font-size: 0.8em;
  color: #fff;
  background-color: rgba(0, 0, 0, 0.7);
  border-radius: 3px; }
  trix-editor .attachment__metadata .attachment__name {
    display: inline-block;
    max-width: 100%;
    vertical-align: bottom;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap; }
  trix-editor .attachment__metadata .attachment__size {
    margin-left: 0.2em;
    white-space: nowrap; }
@charset "UTF-8";
.trix-content {
  line-height: 1.5; }
  .trix-content * {
    box-sizing: border-box;
    margin: 0;
    padding: 0; }
  .trix-content h1 {
    font-size: 1.2em;
    line-height: 1.2; }
  .trix-content blockquote {
    border: 0 solid #ccc;
    border-left-width: 0.3em;
    margin-left: 0.3em;
    padding-left: 0.6em; }
  .trix-content [dir=rtl] blockquote,
  .trix-content blockquote[dir=rtl] {
    border-width: 0;
    border-right-width: 0.3em;
    margin-right: 0.3em;
    padding-right: 0.6em; }
  .trix-content li {
    margin-left: 1em; }
  .trix-content [dir=rtl] li {
    margin-right: 1em; }
  .trix-content pre {
    display: inline-block;
    width: 100%;
    vertical-align: top;
    font-family: monospace;
    font-size: 0.9em;
    padding: 0.5em;
    white-space: pre;
    background-color: #eee;
    overflow-x: auto; }
  .trix-content img {
    max-width: 100%;
    height: auto; }
  .trix-content .attachment {
    display: inline-block;
    position: relative;
    max-width: 100%; }
    .trix-content .attachment a {
      color: inherit;
      text-decoration: none; }
      .trix-content .attachment a:hover, .trix-content .attachment a:visited:hover {
        color: inherit; }
  .trix-content .attachment__caption {
    text-align: center; }
    .trix-content .attachment__caption .attachment__name + .attachment__size::before {
      content: ' · '; }
  .trix-content .attachment--preview {
    width: 100%;
    text-align: center; }
    .trix-content .attachment--preview .attachment__caption {
      color: #666;
      font-size: 0.9em;
      line-height: 1.2; }
  .trix-content .attachment--file {
    color: #333;
    line-height: 1;
    margin: 0 2px 2px 2px;
    padding: 0.4em 1em;
    border: 1px solid #bbb;
    border-radius: 5px; }
  .trix-content .attachment-gallery {
    display: flex;
    flex-wrap: wrap;
    position: relative; }
    .trix-content .attachment-gallery .attachment {
      flex: 1 0 33%;
      padding: 0 0.5em;
      max-width: 33%; }
    .trix-content .attachment-gallery.attachment-gallery--2 .attachment, .trix-content .attachment-gallery.attachment-gallery--4 .attachment {
      flex-basis: 50%;
      max-width: 50%; }
  .trix-button--icon-bold { display: none; }
  .trix-button--icon-increase-nesting-level { display: none; }
  .trix-button--icon-decrease-nesting-level { display: none; }
  .trix-button--icon-bullet-list{ display: none; }
  .trix-button--icon-italic { display: none; }
  .trix-button--icon-code { display: none; }
  .trix-button--icon-heading-1 { display: none; }
  .trix-button--icon-quote { display: none; }
  .trix-button--icon-strike { display: none; }
  .trix-button--icon-undo { display: none; }
  .trix-button--icon-redo { display: none; }
  .trix-button--icon-number-list { display: none; }

length: { maximum: 280 }


<div class="block">
        <a class="overlay" href="<%= tweet_path(tweet.id) %>"></a>
        <div class="inner">
          <p class="tweet_right_options tweet_break">
            <% if current_user.id != tweet.user.id %> 
              <% if current_user.following?(tweet.user) %>
                  <%= link_to "Unfollow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :delete }, :class => "follow-btn btn btn-md btn-outline-primary rounded-pill" %>
                <% else %>
                  <%= link_to "Follow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :post }, :class => "follow-btn btn btn-md btn-outline-primary rounded-pill" %>
              <% end %>
            <% end %>
            &nbsp;<%= link_to "Profile", thisuser_path(tweet.user.id), class: "btn btn-outline-primary btn-md rounded-pill tweet_right_options" %>
          </p>

          <br>
          <div class="row">
            <div class="col-sm-2-5">
              <%= tweets_index_avatar(tweet) %>
            </div>
            <div class="col-10">
                <strong><%= tweet.user.username %></strong>&nbsp;&nbsp;
                <div class="text-inline-tweet">
                  @<%= tweet.user.handle %>&nbsp; · &nbsp;<%= time_ago_in_words(tweet.created_at) %>  
                </div>
              <% if tweet.retweet_id? %>
              <p class="text-small small-text-grey"><i class="fas fa-retweet"></i>&nbsp;Retweeted
                <%= link_to thisuser_path(tweet.source_user_id) do %>
                  @<%= tweet.username %>
                <% end %>
              </p>
              <% end %>
              <br>
              <p>
                <%= tweet.content %>
              </p>
              <br>
            </div>
          </div>
        </div>
        


        <!-- like buttons -->
        <div class="row tweet-buttons">
          <div class="col-1">           
            <% pre_like = tweet.likes.find { |like| like.user_id == current_user.id} %>
              <% if pre_like %>
                <%= link_to '<i class="far fa-thumbs-up"></i>'.html_safe, tweet_like_path(tweet, pre_like), data: { remote: true, type: :json, method: :delete }, :class => "like-btn btn btn-primary btn-sm rounded-pill" %>
              <% else %>
                <%= link_to '<i class="fas fa-thumbs-up"></i>'.html_safe, tweet_likes_path(tweet), data: { remote: true, type: :json, method: :post }, :class => "like-btn btn btn-primary btn-sm rounded-pill" %>
              <% end %>
              &nbsp;&nbsp;<%= tweet.likes.count %>
          </div> 

        


          <div class="col-1">
            <%= link_to '<i class="fas fa-retweet"></i>'.html_safe, retweet_tweet_path(tweet.id), class: "retweet-index btn btn-sm btn-primary rounded-pill", method: :post %>&nbsp;&nbsp;<%= tweet.retweets.count %>
          </div>
            
                
            
          

          <div class="col-1">
              <button type="button" class="btn btn-sm btn-primary rounded-pill" data-toggle="modal" data-target="#exampleModalCenter#<%= tweet.id %>">
                  <i class="fas fa-comment-dots"></i>
                </button> &nbsp;&nbsp;<%= tweet.comments.count %>
          </div>
        </div>
      </div>
      

      

<!-- Reply Modal -->
      <div class="modal fade" id="exampleModalCenter#<%= tweet.id %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
              <p class="modal-title tweet-modal-text text-inline-tweet" id="exampleModalLongTitle">
                <%= tweets_index_avatar(tweet) %>&nbsp;&nbsp;<strong><%= tweet.user.username %></strong>&nbsp;&nbsp;@<%= tweet.user.handle %>&nbsp; · &nbsp;<%= time_ago_in_words(tweet.created_at) %>
              </p>
              <p class= "tweet-modal-text"><%= tweet.content %></p>
              <div class="modal-body">
                <div class="text-center">
                <%= simple_form_for [tweet, @comment] do |f| %>
                <hr />
                  <%= f.text_area :body, :placeholder => 'Reply', :rows => 5, style: 'width:80%;' %><br>
                  <hr />
                  <%= button_tag( :class => "rounded-pill btn btn-primary btn-sm") do %>
                    <i class="fas fa-feather-alt"></i>
                  <% end %>
                <% end %>
                </div>
                <% if tweet.comments.count == 1 %>
                  <%= tweet.comments.count %> Reply
                <% else %>
                  <%= tweet.comments.count %> Replies
                <% end %>
                <br>
                <br>
                <% tweet.comments.reverse.each do |comment| %>
                <div class="row">
                  <div class="col-1">
                    <%= comment_avatar(comment) %>
                  </div>
                  <div class="col-10">
                  <p class="text-small small-text-grey">
                    <strong><%= comment.user.username %></strong>
                    &nbsp;&nbsp;<%= time_ago_in_words(comment.created_at) %>
                  </p>
                  <%= comment.body %>
                  </div>
                </div>
                <hr />
                <% end %>
              </div>
          </div>
        </div>
      </div>   
      <hr/>

       <% if current_user.id != tweet.user.id %> 
              <% if current_user.following?(tweet.user) %>
                  <%= link_to "Unfollow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :delete }, :class => "follow-btn btn btn-md btn-outline-primary rounded-pill" %>
                <% else %>
                  <%= link_to "Follow", relationships_path(user_id: tweet.user), data: { remote: true, type: :json, method: :post }, :class => "follow-btn btn btn-md btn-outline-primary rounded-pill" %>
              <% end %>
            <% end %>