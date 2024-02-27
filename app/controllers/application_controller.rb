class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user! # Routes to the login / signup if not authenticated
  helper_method :current_account
  
  protected
  def authorize_admin
    redirect_back(fallback_location: root_path, alert: "You are not authorized to make that action!") unless current_user.admin?
    #redirects to previous page
  end

  private
  def current_account
    if params[:account_id].present?
      session[:current_account_id] = params[:account_id]
    elsif controller_name == 'accounts' && params[:id].present?
      session[:current_account_id] = params[:id]
    end

    # session[:current_account_id] = 1
    if session[:current_account_id].blank? && current_user
      session[:current_account_id] = current_user.all_accounts.take.try(:id)
    end

    if session[:current_account_id].present?
      begin
        @current_account ||= Account.from_cache(session[:current_account_id])
        return @current_account
      rescue Exception => e
        raise e
      end
    else
      return nil
    end
  end
end
