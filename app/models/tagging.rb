class Tagging < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  validates :tag_id, uniqueness: { scope: :post_id, message: "already has that tag"}
end