class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  validates :comment_body, presence: true, length:{maximum:200}
end
