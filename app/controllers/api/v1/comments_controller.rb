class Api::V1::CommentsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @comments = Comment.all
    render :json => @comments
  end

  def show
    @comment = Comment.find(params[:id])
    render :json => @comment
  end

  def create
    unless params.has_key?(:comment)
      render :status => 400, :json => [errors: "Comment can't be blank"]
      return nil
    end
    params[:comment][:user_id] = current_user.id
    @comment = Comment.new comment_params
    if @comment.save
      render :json => @comment
    else
      render :status => 422, :json => [errors: @comment.errors.full_messages]
    end
  end

  def update
    unless params.has_key?(:comment)
      render :status => 400, :json => [errors: "Comment can't be blank"]
      return nil
    end
    @comment = Comment.find params[:id]
    if current_user.id != @comment.user.id
      render :status => 403, :json => []
      return nil
    end
    params[:comment][:user_id] = current_user.id
    if @comment.update_attributes comment_params
      render :json => @comment
    else
      render :status => 422, :json => [errors: @comment.errors.full_messages]
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if current_user.id != @comment.user.id
      render :status => 403, :json => []
      return nil
    end
    @comment.destroy
    render :json => []
  end

  def comment_params
    params.require(:comment).permit(:message, :post_id, :user_id)
  end
end
