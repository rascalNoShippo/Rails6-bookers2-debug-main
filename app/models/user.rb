class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followed_users, through: :reverse_relationships, source: :following

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :following_users, through: :relationships  , source: :follower

  has_many :own_groups, class_name: "Group", foreign_key: "owner_id", dependent: :destroy

  has_many :groups_participation, class_name: "Participation", foreign_key: "user_id", dependent: :destroy
  has_many :participating_groups, through: :groups_participation, source: :group

  has_many :chats_sent, class_name: "Chat", foreign_key: "sender_id", dependent: :destroy
  has_many :chats_received, class_name: "Chat", foreign_key: "receiver_id", dependent: :destroy

  has_many :visiters, foreign_key: "visiter_id"

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def following(following) #user_a.following(user_b) => user_a has been followed by user_b
    Relationship.find_by(following_id: following.id, follower_id: id)
  end

  def follower(follower) #user_a.follower(user_b) => user_a has been following user_b
    Relationship.find_by(following_id: id, follower_id: follower.id)
  end
=begin
  def following_users
    Relationship.where(following_id: id)
  end

  def followed_users
    Relationship.where(follower_id: id)
  end
=end
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end