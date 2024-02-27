class DomainsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :find_domain, only: [:show, :edit, :update, :destroy, :verify]

  def index
    @domains = Domain.where(account_id: current_account.id).paginate(page: params[:page])
  end

  def show
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = current_account.domains.new(domain_params)
    respond_to do |format|
      if @domain.save
        format.html { redirect_to account_domain_path(current_account, @domain), notice: 'Domain was successfully created.' }  
      else
        flash[:error] = @domain.errors.full_messages
        format.html { render action: 'new' }  
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @domain.update(domain_params.except(:name).merge(verified: false))
        format.html { redirect_to account_domains_path(current_account), notice: 'Domain was successfully updated.' }  
      else
        flash[:error] = @domain.errors.full_messages
        format.html { render action: 'edit' }  
      end
    end
  end

  def destroy
    respond_to do |format|
      if @domain.destroy
        flash[:success] = "Domain was successfully deleted."
        format.js { render js: "window.location = '#{account_domains_path(current_account)}'" }
      end
    end
  end

  def verify
    @domain.verify
    if @domain.errors.present?
      flash[:error] = @domain.errors.full_messages
    elsif @domain.verified
      flash[:notice] = "Domain verified"
    else
      Rails.logger.warn("unexpected case while verifying domain " + @domain.name)
      flash[:notice] = "Somwthing went wrong. Please contact support."
    end
    redirect_to account_domain_path(current_account, @domain)
  end

  private

    def domain_params
      params.require(:domain).permit(:name, :sending_enabled, :return_path_enabled, :branded_link_enabled)
    end

    def find_domain
      @domain = Domain.find_by(id: params[:id], account_id: current_account.id)
      raise ActiveRecord::RecordNotFound unless @domain.present?
    end
end
