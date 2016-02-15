class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :owned_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create

    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created."
      redirect_to posts_path
    else
      flash.now[:alert] = "Post could not be created, please check the form again."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Post could not be updated. Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to posts_path
  end

end

private

#Accept image and caption in the create method
def post_params
  params.require(:post).permit(:image, :caption)
end

def find_post
  @post = Post.find(params[:id])
end

def owned_post
  unless current_user == @post.user
    flash[:alert] = "These are not your posts."
    redirect_to root_path
  end
end