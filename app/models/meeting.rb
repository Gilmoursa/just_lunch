# == Schema Information
#
# Table name: meetings
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string
#  time          :string
#

class Meeting < ActiveRecord::Base
  has_many :guests
  belongs_to :restaurant
  has_many :invitations
  has_many :users, through: :invitations
  has_many :restaurants
  before_save :get_restaurant

  def get_restaurant
    self.restaurant = Restaurant.search
  end
  
  def build_guests(invitation_meetings)
    invitation_meetings.each do |invitation|
      guest = invitation.meeting.guests.build
      guest.user_id = invitation.user_id
      guest.save
    end
  end

  def change_meeting_status(updated_invitation)
    invitation_meetings = Meeting.all.map(&:invitations).flatten.select{|invitation| invitation.meeting == updated_invitation.meeting}
    meeting = invitation_meetings.first.meeting
    if invitation_meetings.find{|invitation| invitation.status == "Decline"}
      meeting.status='declined'
    elsif invitation_meetings.find{|invitation| invitation.status == "pending"}
      return
    else
      meeting.status='accepted'
      self.build_guests(invitation_meetings)
    end
    meeting.save
  end
end
