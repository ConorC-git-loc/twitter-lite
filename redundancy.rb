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