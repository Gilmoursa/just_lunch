# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  rating     :float
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Restaurant < ActiveRecord::Base
  has_many :meetings
end
