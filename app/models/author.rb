class Author < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {minimum:3, maximum:50}
  validates :email, presence: true, length: {minimum:3, maximum:100},
    format: { with: VALID_EMAIL_REGEX},  uniqueness: { case_sensitive: false }
    validates :password, presence: true, allow_nil: true, length: {minimum:6}
  before_save :email_down
  has_secure_password

  private
  def email_down
    self.email = email.downcase
  end
  
end
