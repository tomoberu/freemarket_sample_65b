class Item < ApplicationRecord

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  has_many :photos
  # accepts_nested_attributes_for :images, allow_destroy: true
end
