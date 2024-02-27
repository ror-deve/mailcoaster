# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.find_by(username: params[:username])
  end

  def upload_avatar
    respond_to do |format|
      if current_user.update(user_params)
        flash.now[:success] = "Profile image updated successfully."
      else
        flash[:error] = "Something went wrong!!!!!!"
      end
      format.js { }
    end
  end

  def update
    if current_user.update(user_params)
      flash.now[:success] = "Profile updated successfully."
    else
      flash[:error] = "Something went wrong!!!!!!"
    end
    render turbo_stream: turbo_stream.update("flash", partial: "shared/flash_messages")
  end

  def change_password
    respond_to do |format|
      @user = current_user
      if @user.valid_password?(params[:current_password])
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]
        if @user.save
          bypass_sign_in(@user)
          flash.now[:success] = "password changed successfully."
        else
          @error = true
        end
      else
        flash.now[:error] = "Your current password is incorrect!!!"
      end
      format.js { }
    end 
  end 

  def update_profile
    respond_to do |format|
      @user = current_user
      if request.patch?
        if @user.update(user_params)
          flash.now[:success] = "Profile updated successfully."    
        end
      else
        flash.now[:error] = "Something went wrong, please try again!!!"
      end
      format.js { }
    end 
  end 
  protected

  def user_params
    params.require(:user).permit(:id, :name, :email, :username, :avatar, :current_password, :password, :password_confirmation, :first_name, :last_name, :country, :state, :phone)
  end  
end
