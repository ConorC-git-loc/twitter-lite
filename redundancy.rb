<%= form_for(current_user.active_relationships.find_by(followed_id: tweet.user), html: { method: :delete }) do |f| %>
    <%= f.submit "Unfollow", class: "btn btn-primary" %>

    <div class="col-lg-6"></div>

    <%= render partial: '/shared/tweets', collection: @tweets, as: :tweet %>