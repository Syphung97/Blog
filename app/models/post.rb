class Post < ApplicationRecord
  enum catalogs: [:html,:css,:javascript,:ruby]
  belongs_to :author
  has_many :comments
  validates :author_id, presence: true
  validates :title, presence: true, length: { maximum:50}
  validates :content, presence: true, length:{maximum: 500}
  validates :catalog, inclusion: {in: catalogs.keys}
  mount_uploader :picture, PictureUploader
  scope :desc, ->{order created_at: :desc}
  scope :following_feed, (lambda do |following_ids, id|
    where "author_id IN (?) OR author_id = ?", following_ids, id
  end)
  scope :not_following_feed, (lambda do |following_ids, id|
    where "author_id NOT IN (?) OR author_id != ?", following_ids, id
  end)
  # Ex:- scope :active, -> {where(:active => true)}

end
