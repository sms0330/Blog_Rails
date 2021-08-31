class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  validates :comment_id, uniqueness: { scope: :user_id, message: "Has already been liked"}
end
