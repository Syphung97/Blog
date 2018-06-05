class Relationship < ApplicationRecord
    belongs_to :follower, class_name: Author.name
    belongs_to :followed, class_name: Author.name
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
