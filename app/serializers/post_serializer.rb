class PostSerializer < ActiveModel::Serializer
  attributes(
    :id, 
    :title,
    :body,
    :created_at,
    :updated_at,
    :favourites_count,
    :tags
  )

  #-----------------------------Associations--------------->

  belongs_to :user, key: :author

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email
  end

  has_many :comments
  class CommentSerializer < ActiveModel::Serializer
    attributes :id, :body, :created_at, :updated_at, :author_name, :like_count

    def author_name
      object.user&.name
    end

    def like_count
      object.likes.count
    end
  end

  #-----------------------Custom methods and attributes to render in JSON format--->

  def favourites_count
    object.favourites.count
  end
end