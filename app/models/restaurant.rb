# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  rating     :float
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string
#  name       :string
#  food       :string
#  url        :string
#  postal     :string
#  image      :string
#
class Restaurant < ActiveRecord::Base
  has_many :meetings

  def self.search(zip_code)
    restaurant = Yelp.client.search(zip_code, {term: 'food'}).businesses.sample(1)
    name = restaurant.first.name
    location = restaurant.first.location.display_address.join(', ')
    phone = restaurant.first.phone
    food = restaurant.first.categories.flatten[0]
    url = restaurant.first.url
    postal_code = restaurant.first.location.postal_code
    rating = restaurant.first.rating
    image = restaurant.first.image_url
    Restaurant.create(name: name, location: location, phone: phone, food: food, url: url, postal: postal_code, rating:rating, image: image)
  end

end

