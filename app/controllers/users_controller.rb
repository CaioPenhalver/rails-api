class UsersController < ApplicationController
  before_action :authenticate, except: [:create]

  def show
    @user = User.find(params[:id])
    if @user.nil?
      render json: { error: 'The user is not registered!' }
    else
      render json: @user
    end
  end

  def create
    @user = User.new(user_params)
    if @user
      render json: { msg: 'User has been created successfully!' }
    else
      render json: { error: 'Error has ocurred!' }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { msg: 'User has been updated successfully!' }
    else
      render json: { error: 'Error has ocurred!' }
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    if @user.destroyed?
      render json: { msg: "User profile has been deleted!" }
    else
      render json: { error: "Error has ocurred!" }
    end
  end

  private

  def user_params
    #puts params.to_yaml
    params.require(:user).permit(:name, :email)
  end

end
