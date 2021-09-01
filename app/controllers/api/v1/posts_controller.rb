class Api::V1::PostsController < Api::ApplicationController
    before_action :authenticate_user!, only: [ :create, :destroy, :update ]
    before_action :find_post, only: [:show, :destroy, :update]

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create
        post = Post.new post_params
        post.user = current_user
        post.save!
        render json: { id: post.id }
    end

    def index
        posts = Post.order(created_at: :desc)
        render json: posts
    end

    def show
        if @post
            render(json: @post)
        else
            render(json: {error: "Post Not Found"})
        end
    end

    def update
        @post.update post_params
        render json: { id: @post.id }
    end

    def destroy
        if @post || @post.destroy
            head :ok
        else
            head :bad_request
        end
    end

    private

    def post_params
        params.require(:posts).permit(:title, :body, :image, :tag_names)
    end

    def find_post
        @post = Post.find(params[:id])
    end

    def record_invalid(error)
        invalid_record = error.record
        errors = invalid_record.errors.map do |field, message|
            {
                type: error.class.to_s, 
                record_type: invalid_record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            json: {status: 422, errors: errors },
            status: 422 
        )
    end
end
