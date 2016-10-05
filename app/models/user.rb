class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  MAX_DESCRIPTION_SIZE = 140

  has_many :tweets, dependent: :destroy
  has_many :followings, class_name: 'Follow', foreign_key: :follower_id
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id
  has_many :follower_users, through: :followers, source: :follower
  has_many :following_users, through: :followings, source: :followed
  has_many :notifications, class_name: 'Notification', through: :followers

  validates :description, length: { maximum: MAX_DESCRIPTION_SIZE }
  validates :email, presence: true

  def follows?(user)
    followings.where(followed_id: user.id).any?
  end

end