class PostsController < ApplicationController
  before_action :find_post_id, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    if params[:tag]
        @tag = Tag.find_or_initialize_by(name: params[:tag])
        @posts = @tag.posts.all.order('updated_at DESC')
    else
        @posts = Post.all.order(created_at: :desc) 
    end 
  end
  
  def new
      @post = Post.new
  end

  def create
      @post = Post.new post_params
      @post.user = current_user
      if @post.save
          redirect_to post_path(@post.id), notice: "Post Saved!"
      else
          render :new
      end
  end

  def show
      @comment = Comment.new
      @comments = @post.comments.order(updated_at: :desc)
  end

  def destroy
      @post.destroy
      redirect_to posts_path
  end

  def edit
  end

  def update
      if @post.update post_params
          redirect_to post_path
      else
          render :edit
      end
  end

  def favourited
    @posts = current_user.favourited_posts.order(created_at: :desc)
  end

  private

  def post_params
      params.require(:post).permit(:title, :body, :image, :tag_names)
  end

  def find_post_id
      @post = Post.find params[:id]
  end

  def authorize_user!
    redirect_to root_path, alert: 'Not authorized! please try again' unless can?(:crud, @post)
  end

end