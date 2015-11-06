class InvitationPresenter < BasePresenter
  presents :invitation

  def accept_decline
  # <% if @invitation.status == 'pending' %>
  #   <%= form_tag user_invitation_path(@user, @user.invitations.last), method: :patch do %>
  #     <%= submit_tag 'Accept', name: :status %>
  #     <%= submit_tag 'Decline', name: :status %>
  #   <% end %>
  # <% else %>
  #   You chosen to <%= @invitation.status.downcase %> this invitation.
  # <% end %>
    if invitation.status == 'pending'
      h.form_tag(route.user_invitation_path(invitation.user, invitation), method: :patch) do
        h.submit_tag('Accept', name: :status) + 
        h.submit_tag('Decline', name: :status)
      end
    else
      h.content_tag(:h4, "You chose to #{invitation.status.downcase} this invitation.")
    end
  end
end