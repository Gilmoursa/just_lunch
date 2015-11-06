# == Schema Information
#
# Table name: availabilities
#
#  id         :integer          not null, primary key
#  location   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  time       :string
#

class Availability < ActiveRecord::Base
  belongs_to :user

  # Other aspects - interest (another class)
  # Cuisine (another class)
end
