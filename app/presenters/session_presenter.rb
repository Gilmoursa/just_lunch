class SessionPresenter < BasePresenter
  presents :current_user

  def homepage_text
    if current_user
      # <img src=<%= current_user.image %>>
      # <h3>Welcome back <%= current_user.name %>!</h3>
      h.image_tag(current_user.image)
      h.content_tag(:h3, "Welcome back #{current_user.name}!")
    else
      # <h3><%=link_to "Sign Up", signup_path %> and dine today</h3>
      h.content_tag(:h3, h.link_to("Sign Up", Rails.application.routes.url_helpers.signup_path) + " and dine today")
    end
  end
end