class FavouritesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

    def create
        @post = Post.find params[:post_id]
        @favourite = Favourite.new(post: @post, user: current_user)
        if  cannot?(:favourite, @post)
            flash[:alert] = "You can't favourite your own post!"
        elsif @favourite.save
            flash[:notice] = "Post favourited"
        else
            flash[:alert] = @favourite.errors.full_messages.join(', ')
        end
        redirect_to post_path(@post)
    end

    def destroy
        @favourite = current_user.favourites.find params[:id]
        if cannot?(:destroy, @favourite)
            flash[:alert] = "You cannot destroy a favourite you don't own"
        elsif @favourite.destroy
            flash[:notice] = "Post unfavourited"
        else
            flash[:alert] = "Couldn't Unfavourite the post"
        end
        redirect_to post_path(@favourite.post)
    end
end
