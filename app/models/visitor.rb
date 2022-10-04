class Visitor < ApplicationRecord
  belongs_to :visitor, class_name: "User"
  belongs_to :book
end
