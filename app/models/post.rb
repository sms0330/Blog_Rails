class Post < ApplicationRecord
    has_many :comments, dependent: :destroy

    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user

    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: {minimum: 50}
    belongs_to :user, optional: true

    mount_uploader :image, ImagesUploader
end
