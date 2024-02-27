# frozen_string_literal: true

class CampaignsController < ApplicationController
  include Wicked::Wizard

  steps :step1, :step2, :step3, :step4
  before_action :authenticate_user!
  before_action :new_campaign, only: [:index, :new, :create]
  # before_action :find_campaign, only: [:show, :edit, :destroy, :update]
  respond_to :json, :xml, :html, :js

  def index
    @folders, @campaigns = Folder.folder_with_associate_data(current_account, params[:folder_id], Campaign)
  end

  def new_template

  end

  def new

  end

  def show
    @campaign = current_account
    render_wizard 
  end

  def create
    respond_to do |format|
      @campaign = current_account.campaigns.new(campaign_params)
      if @campaign.save
        format.html { redirect_to account_campaigns_path(current_account), notice: 'Campaign was successfully created.' }  
      else
        flash[:error] = @campaign.errors.full_messages
        format.html { render action: 'new' }  
      end
    end
  end

  def edit

  end

  def update
    @campaign = current_account
    @campaign.update_attributes(campaign_params)
    render_wizard @campaign
  end

  def destroy
  end

  protected
  def campaign_params
    params.require(:campaign).permit(:folder_id, :account_id, :name, :content_id, :html_part, :content_history_id)
  end  

  private

  def redirect_to_finish_wizard(options, params)
    redirect_to root_path, notice: "Thank you for the Visiting"
  end

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def new_campaign
    @campaign = current_account.campaigns.new()
  end

  def find_campaign
    @campaign = current_account.campaigns.find_by_id(params[:id])
  end
end
