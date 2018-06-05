class Post < ApplicationRecord
  enum catalogs: [:html,:css,:javascript,:ruby]
  belongs_to :author
  validates :author_id, presence: true
  validates :title, presence: true, length: { maximum:50}
  validates :content, presence: true, length:{maximum: 500}
  validates :catalog, inclusion: {in: catalogs.keys}
  mount_uploader :picture, PictureUploader
  scope :desc, ->{order created_at: :desc}
  # Ex:- scope :active, -> {where(:active => true)}

end
