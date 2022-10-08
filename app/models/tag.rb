class Tag < ApplicationRecord
  has_many :books_relationships, class_name: "BookTag"
  has_many :books, through: :books_relationships
end
