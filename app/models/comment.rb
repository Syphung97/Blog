class Comment < ApplicationRecord
    belongs_to :author
    belongs_to :post
    validates :author_id, presence: true
    validates :post_id, presence: true
    validates :content, presence: true, length: {maximum: 200}
end
