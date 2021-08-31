class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify

    has_many :favourites
    has_many :favourited_posts, through: :favourites, source: :post

    has_many :likes
    has_many :liked_comments, through: :likes, source: :comment

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
end
