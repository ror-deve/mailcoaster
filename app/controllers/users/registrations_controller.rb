class Users::RegistrationsController < Devise::RegistrationsController
  layout 'devise_layout', only: [:new, :create]
  skip_before_action :verify_authenticity_token

  def new
    super
  end

  def create
    super
  end

  protected

  def after_update_path_for resource
    root_url
  end

  def after_sign_up_path_for resource
    root_path
    
    # ------> refernce code for future
    # case resource
    # when :user, User
    #   resource.teacher? ? another_path : root_path
    # else
    #   super
    # end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :username, :avatar, :password, :password_confirmation, :remember_me, :created_at, :updated_at)
  end  
end
