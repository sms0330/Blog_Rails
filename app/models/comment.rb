class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, optional: true
  validates :body, presence: true

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
end
