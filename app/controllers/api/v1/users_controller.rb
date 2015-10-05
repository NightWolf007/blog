class Api::V1::UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @users = User.all
    render :json => @users
  end

  def show
    @user = User.find(params[:id])
    render :json => @user
  end
end