class Post < ApplicationRecord
    has_many :comments, dependent: :destroy

    has_many :favourites, dependent: :destroy
    has_many :favouriters, through: :favourites, source: :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: {minimum: 50}
    belongs_to :user, optional: true

    mount_uploader :image, ImagesUploader

    def tag_names
        self.tags.map(&:name).join(", ")
    end

    def tag_names=(rhs)
        self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
            Tag.find_or_initialize_by(name: tag_name)
        end
    end
end
