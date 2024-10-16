class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: { message: "コメントは必須です。" }
  validates :content, length: { maximum: 255 }
end
