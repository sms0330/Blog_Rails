class LikesController < ApplicationController
    before_action :authenticate_user!
    def create
        comment = Comment.find(params[:comment_id])
        like = Like.new(user: current_user, comment: comment)
        @post = Post.find(params[:post_id])
        if cannot?(:like, comment)
            flash[:alert] = "You can't like your own comment!"
        elsif like.save
            flash[:notice] = "Comment Liked!"
        else
            flash[:alert] = like.errors.full_messages.join(', ')
        end
        redirect_to post_path(@post)
    end

    def destroy
        like = current_user.likes.find(params[:id])
        @post = like.comment.post
        if cannot?(:destroy, like)
            flash[:alert] = "You can't destroy a like you don't own!"
        elsif like.destroy
            flash[:notice] = "Comment Unliked!"
        else
            flash[:alert] = "Couldn't Unlike the comment!"
        end
        redirect_to post_path(@post)
    end
end