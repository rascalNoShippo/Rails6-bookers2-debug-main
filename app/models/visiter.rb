class Visiter < ApplicationRecord
  belongs_to :visiter, class_name: "User"
  belongs_to :book
end
