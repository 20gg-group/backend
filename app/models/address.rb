class Address < ApplicationRecord
  belongs_to :post
  belongs_to :district
  #before_save :save_city
 # validates :city,:district,:street,:house_no , presence: true
  # def save_city(district)
  #   self.city = district.city
  # end
end
