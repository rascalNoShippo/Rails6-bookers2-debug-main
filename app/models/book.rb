class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :visitors

  has_many :tags_relationships, class_name: "BookTag", dependent: :destroy
  has_many :tags, through: :tags_relationships

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :evaluation, presence: true

  def favorited?(user)
    favorites.exists?(user_id: user.id)
  end

end
