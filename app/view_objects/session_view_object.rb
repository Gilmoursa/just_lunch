class SessionViewObject
  attr_reader :current_user
  def initialize(current_user)
    @current_user = current_user
  end

  def homepage_text
    if current_user
      # <img src=<%= current_user.image %>>
      # <h3>Welcome back <%= current_user.name %>!</h3>
      
    else
      <h3><%=link_to "Sign Up", signup_path %> and dine today</h3>
    end
  end
end