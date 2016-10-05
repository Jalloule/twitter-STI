class Follow < ActiveRecord::Base

  belongs_to :follower, class_name: 'User', required: true
  belongs_to :followed, class_name: 'User', required: true
  has_many :notifications, dependent: :destroy

  scope :not_accepted, -> { where(accepted: false) }

  validates :follower_id, uniqueness: { scope: [:followed_id] }
  validate :cannot_follow_self
  before_validation :needs_to_accept?, on: :create

  delegate :name, to: :follower, prefix: true, allow_nil: true
  #follower_name => follower.name

  def accept
    update_attribute('accepted', true)
  end

  private

  def cannot_follow_self
    errors.add(:followed_id, 'You cannot follow yourself!') if follower_id == followed_id
    true
  end

  # accepted = true unless followed
  # accepted = false if followed.need_accept => true
  # accepted = true if followed.need_accept => false
  def needs_to_accept?
    self.accepted = followed ? !followed.need_accept? : true
    true
  end
end