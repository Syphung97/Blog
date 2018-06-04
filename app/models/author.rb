class Author < ApplicationRecord

  attr_accessor :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
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

  private
  def email_down
    self.email = email.downcase
  end
  

end
