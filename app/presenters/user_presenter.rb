class UserPresenter < BasePresenter
  presents :user
  #   <% if @user.invitations.count > 0 %>
  #   <% if @user.invitations.last.status == "pending" %>
  #     <%= link_to 'Pending Invitation!', user_invitation_path(@user, @user.invitations.last) %>
  #   <% else %>
  #     <% if @user.meetings.last.status == "pending" %>
  #       Waiting on lunch partner to respond.
  #     <% elsif @user.meetings.last.status == "declined" %>
  #       No pending invitations, please check back tomorrow.
  #     <% else %>
  #       <%= link_to "Today's Lunch", user_meeting_path(@user, @user.meetings.last) %>
  #     <% end %>
  #   <% end %>
  # <% end %>
  def pending_invitation
    if !new_user?
      if user.invitations.last.status == "pending"
        h.link_to('Pending Invitation!', route.user_invitation_path(user, user.invitations.last))
      else
        meeting_status
      end
    end
  end


  def new_user?
    user.invitations.count == 0
  end

  # def pending_invitation
  # #   <% if @user.invitations.last.status == "pending" %>
  # #     <%= link_to 'Pending Invitation!', user_invitation_path(@user, @user.invitations.last) %>
  #   if user.invitations.last.status == "pending"
  #     h.link_to('Pending Invitation!', user_invitation_path(user, user.invitations.last))
  #   end
  # end

  def meeting_status
  #     <% if @user.meetings.last.status == "pending" %>
  #       Waiting on lunch partner to respond.
  #     <% elsif @user.meetings.last.status == "declined" %>
  #       No pending invitations, please check back tomorrow.
  #     <% else %>
  #       <%= link_to "Today's Lunch", user_meeting_path(@user, @user.meetings.last) %>
  #     <% end %>
    if user.meetings.last.status == "pending"
      h.content_tag(:p, "Waiting on lunch partner to respond.")
    elsif user.meetings.last.status == "declined"
      h.content_tag(:p, "No pending invitations, please check back tomorrow.")
    else
      h.link_to("Today's Lunch", route.user_meeting_path(user, user.meetings.last))
    end
  end
end