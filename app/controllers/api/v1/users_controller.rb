class Api::V1::UsersController < ApplicationController
  @@default_page_number = 1
  @@default_page_size = 5

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @number = params[:page] && params[:page][:number] ? params[:page][:number] : @@default_page_number
    @size = params[:page] && params[:page][:size] ? params[:page][:size] : @@default_page_size
    @users = User.page(@number).per(@size)
    render :json => @users
  end

  def show
    @user = User.find params[:id]
    if current_user && current_user.id == @user.id
      render :json => @user, :serializer => CurrentUserSerializer
    else
      render :json => @user
    end
  end

  def update
    unless params.has_key?(:user)
      render :status => 400, :json => { errors: "User can't be blank" }
      return nil
    end

    @user = User.find params[:id]
    if current_user.id != @user.id
      render :status => 403, :json => {}
      return nil
    end

    if @user.update_attributes user_params
      sign_in @user, bypass: true if params.has_key?(:password)
      render :json => @user
    else
      render :status => 422, :json => { errors: @user.errors.full_messages }
    end
  end

  def destroy
    @user = User.find params[:id]
    unless current_user.id == @user.id || current_user.is_admin?
      render :status => 403, :json => {}
      return nil
    end
    DeleteImage.new(@user.image).execute
    @user.destroy
    render :json => @user
  end

  def user_params
    p = params.require(:user).permit(:email, :name, :surname, :password, :avatar)
    p[:image] = p[:img] ? p.delete(:avatar).split('/').last : nil
    return p
  end
end