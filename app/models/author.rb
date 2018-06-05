class Author < ApplicationRecord
  attr_accessor :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :name, presence: true, length: {minimum:3, maximum:50}
  validates :email, presence: true, length: {minimum:3, maximum:100},
    format: { with: VALID_EMAIL_REGEX},  uniqueness: { case_sensitive: false }
    validates :password, presence: true, allow_nil: true, length: {minimum:6}
  before_save :email_down
  has_secure_password
  
  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

  end
  def remember
    self.remember_token = Author.new_token
    update_attributes(remember_digest: Author.digest(remember_token))
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes(remember_digest: nil)
  end

  def current_author? current_author
    self == current_author
  end

  def feed
    Post.following_feed(following_ids, id)
  end

  def follow(other_author)
    following << other_author
  end

  # Unfollows a author.
  def unfollow(other_author)
    following.delete(other_author)
  end

  # Returns true if the current author is following the other author.
  def following?(other_author)
    following.include?(other_author)
  end
  private
  def email_down
    self.email = email.downcase
  end
  

end
