class Api::V1::TagsController < ApplicationController
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @page = params[:page] && params[:page][:number] ? params[:page][:number] : DEFAULT_PAGE
    @per_page = params[:page] && params[:page][:size] ? params[:page][:size] : DEFAULT_PER_PAGE

    @tags = Tag.paginate page: @page, per_page: @per_page
    render :json => @tags
  end

  def show
    @tag = Tag.find(params[:id])
    render :json => @tag
  end

  def create
    unless params.has_key?(:tag)
      render :status => 400, :json => { errors: "Tag can't be blank" }
      return nil
    end
    @tag = Tag.new tag_params
    if @tag.save
      render :json => @tag
    else
      render :status => 422, :json => { errors: @tag.errors.full_messages }
    end
  end

  def destroy
    unless current_user.is_admin?
      render :status => 403, :json => {}
      return nil
    end
    @tag = Tag.find params[:id]
    @tag.destroy
    render :json => @tag
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end