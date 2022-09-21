class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :participations
  
  has_many :group_members, class_name: "Participation", foreign_key: "group_id", dependent: :destroy
  has_many :members, through: :group_members, source: :user
  
  validates :name,presence:true
  validates :introduction, presence:true,length:{maximum:200}
end
