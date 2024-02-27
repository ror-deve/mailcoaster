class ContentTemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content_template, only: [:edit, :update, :destroy]
  before_action :new_content_template, only: [:index, :new, :create]
  before_action :set_image_folder, only: [:new, :edit]
  respond_to :json, :xml, :html, :js
  require 'liquid'

  def index
    @folder_id = params[:folder_id].present? ? params[:folder_id] : Folder.roots.where(folder_type: "content_template").take.id 
    @folders, content_templates = Folder.folder_with_associate_data(current_account, @folder_id, ContentTemplate)
    @content_templates = content_templates.paginate(page: params[:page])
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

  def show
    
  end

  def edit
   
  end

  def create
    respond_to do |format|
      @content_template = current_account.content_templates.new(content_template_params)
      if @content_template.save
        format.html { redirect_to account_content_templates_path(current_account), notice: 'Content Template was successfully created.' }  
      else
        flash[:error] = @content_template.errors.full_messages
        format.html { render action: 'new' }  
      end
      
    end
  end

  def update
    respond_to do |format|
      if @content_template.update(content_template_params)
        format.html { redirect_to account_content_templates_path(current_account), notice: 'Content Template was successfully updated.' }
      else
        flash[:error] = @content_template.errors.full_messages
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @content_template.destroy
        flash[:success] = "Content Template was successfully deleted."
        format.js { render js: "window.location = '#{account_content_templates_path(current_account)}'" }
      end
    end    
  end

  def preview
    @content_template = ContentTemplate.find(params[:id])
    @content_template.html_part = Liquid::Template.parse(@content_template.html_part).render('template' => @templates)
    render layout: false
  end

  protected
  def content_template_params
    params.require(:content_template).permit(:id, :account_id, :name, :html_part, :editor_ids, :owner_id, :tag_name, :folder_id, :permissions)
  end

  private
  def new_content_template
    @content_template = current_account.content_templates.new()
  end

  def set_content_template
    @content_template = current_account.content_templates.find(params[:id])
  end

  def set_image_folder
    @folders = current_account.folders.content_image_folders.roots.sorted
    @content_images = current_account.content_images.without_folder.sorted
  end

end
