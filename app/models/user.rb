# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string
#  password_digest :string
#

class User < ActiveRecord::Base
  has_many :invitations
  has_many :availabilities
  has_many :guests
  has_many :meetings, through: :invitations
  has_many :restaurants, through: :meetings
  before_save :set_time_location, :set_photo
  has_secure_password
  validates_presence_of :name, :email, :password_digest, :birthdate
  validates :email, uniqueness: true

  def set_photo
    self.image = "http://api.randomuser.me/portraits/med/#{["men","women"].sample}/#{rand(1..35)}.jpg"
  end

  def set_time_location
    self.availabilities.build(time: "12", location:"10004") 
  end

  def accept_rate
    accepted = self.invitations.select{|invitation| invitation.status == 'Accept'}.count
    invitations = self.invitations.count
    (accepted.to_f/invitations*100).round(2)
  end

  def age
    date_hash = eval(self.birthdate)
    dob = DateTime.new(date_hash[1],date_hash[2],date_hash[3]) 
    now = Date.today
    age = ((now - dob) / 365.25).to_i
  end

  private

  def self.sort_array_by(user_array, attribute)
    user_array.sort_by do |user|
      user.availabilities.first.send(attribute)
    end
  end

  def self.time_filter(user_array)
    sorted_array = self.sort_array_by(user_array, 'time')
    sorted_array.chunk do |user|
      user.availabilities.first.time
    end.to_h.values
  end

  def self.location_filter(user_array)
    sorted_array = self.sort_array_by(user_array, 'location')
    sorted_array.chunk do |user|
      user.availabilities.first.location
    end.to_h.values
  end

  def self.apply_filters
    time_results = self.time_filter(User.all)
    location_results = time_results.map do |time_result|
      self.location_filter(time_result)
    end.flatten(1)
  end
end
