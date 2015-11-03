# == Schema Information
#
# Table name: meetings
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  time          :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Meeting < ActiveRecord::Base
  has_many :guests
  has_many :invitations, through: :guests
  has_many :users, through: :invitations
  has_many :restaurants, through: :invitations
end
