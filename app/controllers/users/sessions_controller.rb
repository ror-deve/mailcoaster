class Users::SessionsController < Devise::SessionsController 
  layout 'devise_layout'
  skip_before_action :verify_authenticity_token
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    params.require(:user).permit(:login, :password, :remember_me)
  end
end
