class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]

    def create
        comment_params = params.require(:comment).permit(:body)
        @comment = Comment.new comment_params
        @post = Post.find params[:post_id]
        @comment.post = @post
        @comment.user = current_user

        if can? :crud, @comment
            if @comment.save
                redirect_to post_path(@post), notice: "New Comment!"
            else
                @comments = @post.comments.order(created_at: :desc)
                render 'posts/show', alert: "error!"
            end
        else
            redirect_to root_path, alert: "Not authorized!"
        end

    end

    def destroy
        comment = Comment.find params[:id]
        if can? :crud, comment
            comment.destroy
            redirect_to post_path(comment.post_id)
        else
            redirect_to root_path, alert: "Not authorized!"
        end
    end
end