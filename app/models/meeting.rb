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

  def change_meeting_status(updated_invitation)
    invitation_meetings = Meeting.all.map(&:invitations).flatten.select{|invitation| invitation.meeting == updated_invitation.meeting}
    meeting = invitation_meetings.first.meeting
    if invitation_meetings.find{|invitation| invitation.status == "Decline"}
      meeting.status='declined'
    elsif invitation_meetings.find{|invitation| invitation.status == "pending"}
      return
    else
      meeting.status='accepted'
    end
    meeting.save
  end
end
