class Api::V1::UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @users = User.all
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
      render :status => 400, :json => [errors: "User can't be blank"]
      return nil
    end

    @user = User.find params[:id]
    if current_user.id != @user.id
      render :status => 403, :json => {}
      return nil
    end

    if @user.update_attributes user_params
      render :json => @user
    else
      render :status => 422, :json => [errors: @user.errors.full_messages]
    end
  end

  def destroy
    @user = User.find params[:id]
    unless current_user.id == @user.id || current_user.is_admin?
      render :status => 403, :json => {}
      return nil
    end
    @user.destroy
    render :json => @user
  end

  def user_params
    params.require(:user).permit(:email, :name, :surname)
  end
end