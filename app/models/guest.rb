# == Schema Information
#
# Table name: guests
#
#  id         :integer          not null, primary key
#  meeting_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Guest < ActiveRecord::Base
  belongs_to :user
  belongs_to :meeting
end
