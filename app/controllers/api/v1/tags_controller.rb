class Api::V1::TagsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @tags = Tag.all
    render :json => @tags
  end

  def show
    @tag = Tag.find(params[:id])
    render :json => @tag
  end

  def create
    unless params.has_key?(:tag)
      render :status => 400, :json => [errors: "Tag can't be blank"]
      return nil
    end
    @tag = Tag.new tag_params
    if @tag.save
      render :json => @tag
    else
      render :status => 422, :json => [errors: @tag.errors.full_messages]
    end
  end

  def destroy
    unless current_user.is_admin?
      render :status => 403, :json => []
      return nil
    end
    @tag = Tag.find params[:id]
    if current_user.id != @tag.user.id
      render :status => 403, :json => []
      return nil
    end
    @tag.destroy
    render :json => @tag
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end