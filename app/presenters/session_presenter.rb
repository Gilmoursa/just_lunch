class SessionPresenter < BasePresenter
  presents :current_user

  def nav_bar
    # <% if current_user %>
    # <li>
    #     <%=link_to "#{current_user.name.capitalize}'s Profile",user_path(current_user) %>
    # </li>
    # <li>
    #     <%=link_to "Log Out",logout_path %>
    # </li>
    # <li>
    # <div id ="headerpic">
    #     <%= image_tag current_user.image %>
    #     </div>
    # </li>
    # <% else %>
    # <li>
    #     <%=link_to "Sign Up", signup_path %>
    # </li>
    # <li>
    #     <%=link_to "Log In", login_path %>
    # </li>
    # <% end %>
    if current_user
      h.content_tag(:li, h.link_to("#{current_user.name}'s Profile", route.user_path(current_user))) +
      h.content_tag(:li, h.link_to("Log Out", route.logout_path)) +
      h.content_tag(:li, h.content_tag(:div, :id => "headerpic")  do
        h.image_tag(current_user.image)
      end)
    else
      h.content_tag(:li, h.link_to("Sign Up", route.signup_path)) +
      h.content_tag(:li, h.link_to("Log In", route.login_path))
    end
  end

  def homepage_text
    if current_user
      # <img src=<%= current_user.image %>>
      # <h3>Welcome back <%= current_user.name %>!</h3>
      h.image_tag(current_user.image)
      h.content_tag(:h3, "Welcome back #{current_user.name}!")
    else
      # <h3><%=link_to "Sign Up", signup_path %> and dine today</h3>
      h.content_tag(:h3, h.link_to("Sign Up", route.signup_path) + " and dine today")
    end
  end
end