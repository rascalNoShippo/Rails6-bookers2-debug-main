class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User" #ユーザーA：ユーザーBをフォローしている
  belongs_to :follower, class_name: "User" #ユーザーA：ユーザーBにフォローされている
  
  
end
