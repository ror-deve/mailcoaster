# frozen_string_literal: true

class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_content, only: [:show, :edit, :destroy, :update]
  before_action :new_content, only: [:index, :new, :create]
  before_action :set_image_folder, only: [:new, :edit]
  before_action :set_content_template_list, only: [:new, :edit, :create, :update]
  respond_to :json, :xml, :html, :js

  def index
    @folder_id = params[:folder_id].present? ? params[:folder_id] : Folder.roots.where(folder_type: "content").take.id 
    @folders, contents = Folder.folder_with_associate_data(current_account, @folder_id, Content)
    @contents = contents.paginate(page: params[:page])
    if request.xhr?
      respond_to do |format|
        format.js {}   
      end
    end
  end

  def new_template

  end

  def new
    
  end

  def create
    respond_to do |format|
      @content = current_account.contents.new(content_params)
      if @content.save
        format.html { redirect_to account_contents_path(current_account), notice: 'Content was successfully created.' }  
      else
        flash[:error] = @content.errors.full_messages
        format.html { render action: 'new' }  
      end
    end
  end

  def show
    
  end

  def edit
    
  end

  def preview
    @content = Content.find_by(id: params[:id])
    render layout: false
  end

  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to account_contents_path(current_account), notice: 'Content was successfully updated.' }  
      else
        flash[:error] = @content.errors.full_messages
        format.html { render action: 'edit' }  
      end
    end
  end

  def destroy
    respond_to do |format|
      if @content.destroy
        flash[:success] = "Content was successfully deleted."
        format.js { render js: "window.location = '#{account_contents_path(current_account)}'" }
      end
    end 
  end

  protected
  def content_params
    params.require(:content).permit(:id, :name, :parent_id, :folder_type, :object_class, :html_part, :text_part, :pull_url, :folder_id, :content_template_id, :account_id)
  end

  private
  def find_content
    @content = current_account.contents.find_by_id(params[:id])
  end
  
  def new_content
    @content = current_account.contents.new()
  end

  def set_image_folder
    @folders = current_account.folders.content_image_folders.roots.sorted
    @content_images = current_account.content_images.without_folder.sorted
  end

  def set_content_template_list
    @content_template_list = current_account.content_templates.pluck(:name, :id)
    respond_to do |format|
      format.html
      format.json do
        content_template_id = params[:search_term]
        content_template = ContentTemplate.find(content_template_id)
        
        render json: { html_part: content_template.html_part }
      end
    end
  end
end
