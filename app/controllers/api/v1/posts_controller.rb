class Api::V1::PostsController < ApplicationController
  @@default_page_number = 1
  @@default_page_size = 5

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @number = params[:page] && params[:page][:number] ? params[:page][:number] : @@default_page_number
    @size = params[:page] && params[:page][:size] ? params[:page][:size] : @@default_page_size
    @posts = Post.page(@number).per(@size)
    render :json => @posts
  end

  def show
    @post = Post.find(params[:id])
    render :json => @post
  end

  def create
    unless params[:post]
      render :status => 400, :json => { errors: "Post can't be blank" }
      return nil
    end

    params[:post][:user] = current_user.id
    @tags = params[:post].delete(:tags)

    @post = Post.new post_params
    if @post.save
      if @tags && @tags.kind_of?(Array)
        @post.tags.destroy_all
        @tags.each do |e|
          @post.tags << Tag.find(e)
        end
      end

      render :json => @post
    else
      render :status => 422, :json => { errors: @post.errors.full_messages }
    end
  end

  def update
    unless params[:post]
      render :status => 400, :json => { errors: "Post can't be blank" }
      return nil
    end

    @post = Post.find params[:id]
    if current_user.id != @post.user.id
      render :status => 403, :json => {}
      return nil
    end

    params[:post][:user] = current_user.id
    @tags = params[:post].delete(:tags)

    if @post.update_attributes post_params
      if @tags && @tags.kind_of?(Array)
        @post.tags.destroy_all
        @tags.each do |e|
          @post.tags << Tag.find(e)
        end
      end

      render :json => @post
    else
      render :status => 422, :json => { errors: @post.errors.full_messages }
    end
  end

  def destroy
    @post = Post.find params[:id]
    if current_user.id != @post.user.id
      render :status => 403, :json => {}
      return nil
    end
    DeleteImage.new(@post.image).execute
    @post.destroy
    render :json => @post
  end

  def post_params
    p = params.require(:post).permit(:title, :text, :user, :img)
    p[:user_id] = p.delete(:user)
    p[:image] = p[:img] ? p.delete(:img).split('/').last : nil
    return p
  end
end
