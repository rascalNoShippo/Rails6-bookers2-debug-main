class Group < ApplicationRecord
  belongs_to :owner, class_name:  "User"
  has_many :participations
  
  validates :name,presence:true
  validates :introduction, presence:true,length:{maximum:200}
end
