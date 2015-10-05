class Api::V1::PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all
    render :json => @posts
  end

  def show
    @post = Post.find(params[:id])
    render :json => @post
  end

  def create
    unless params.has_key?(:post)
      render :status => 400, :json => [errors: "Post can't be blank"]
      return nil
    end

    params[:post][:user_id] = current_user.id

    if params[:post][:img] && !params[:post][:img].is_a?(String)
      params[:post][:image] = upload_image params[:post][:img]
    else
      params[:image] = nil
    end

    @post = Post.new post_params
    if @post.save
      params[:post][:tags].each do |e|
        @post.tags << Tag.find(e)
      end
      render :json => @post
    else
      render :status => 422, :json => [errors: @post.errors.full_messages]
    end
  end

  def update
    unless params.has_key?(:post)
      render :status => 400, :json => [errors: "Post can't be blank"]
      return nil
    end

    @post = Post.find params[:id]
    if current_user.id != @post.user.id
      render :status => 403, :json => []
      return nil
    end

    params[:post][:user_id] = current_user.id

    params[:post].delete :image
    if params[:post][:img] && !params[:post][:img].is_a?(String)
      remove_image @post.image
      params[:post][:image] = upload_image params[:post][:img]
    end

    if @post.update_attributes post_params
      p @post.tags
      @post.tags.destroy_all
      params[:post][:tags].each do |e|
        @post.tags << Tag.find(e)
      end
      p @post.tags
      render :json => @post
    else
      render :status => 422, :json => [errors: @post.errors.full_messages]
    end
  end

  def destroy
    @post = Post.find params[:id]
    if current_user.id != @post.user.id
      render :status => 403, :json => []
      return nil
    end
    @post.destroy
    render :json => []
  end

  def post_params
    params.require(:post).permit(:title, :text, :user_id, :tags, :image)
  end

  private

  def upload_image(image)
    images_dir = "public/images"
    filename = "#{SecureRandom.hex(5)}.#{image.original_filename.split('.').last}"

    file = image.read
    File.open("#{images_dir}/#{filename}", 'wb') do |f|
      f.write file
    end

    return filename
  end

  def remove_image(filename)
  end
end