# frozen_string_literal: true

class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_folder, only: [:show, :edit, :destroy, :update]
  respond_to :json, :xml, :html, :js

  def index
    @folders = current_account.folders.content_image_folders.roots.sorted
    @content_images = current_account.content_images.without_folder.sorted
    @new_folder = current_account.folders.new(parent_id: params[:parent_id])
    @new_content_image = current_account.content_images.new(folder_id: params[:parent_id])
  end

  def new
    @new_folder = current_account.folders.new(parent_id: params[:parent_id])
    respond_to do |format|
      format.js { }
    end
  end

  def create
    @folder = current_account.folders.new(folder_params)
    respond_to do |format|
      if @folder.save
        @folders = @folder.folder_list_data(folder_params[:object_class].constantize)
        flash.now[:success] = "Successfully created."
      else
        flash.now[:error] = @folder.errors.full_messages
      end
      format.js { }
    end
  end

  def show
    @folders = @folder.children
    @content_images = current_account.content_images.with_folder(@folder.id).sorted
    @new_folder = current_account.folders.new(parent_id: @folder.id)
    @new_content_image = current_account.content_images.new(folder_id: @folder.id)
  end

  def form_folders
    if (params[:form_folder_id])
      folder = current_account.folders.find_by_id(params[:form_folder_id])
      @folders = folder.children
      @content_images = current_account.content_images.with_folder(folder.id).sorted
    else
      @folders = current_account.folders.content_image_folders.roots.sorted
      @content_images = current_account.content_images.without_folder.sorted
    end
    respond_to do |format|
      format.js { }
    end
  end

  def edit
    respond_to do |format|
      format.js { }
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        @folders = @folder.folder_list_data(folder_params[:object_class].constantize)
        flash.now[:success] = "Successfully updated"
      else
        flash.now[:error] = @folder.errors.full_messages
      end
      format.js { }
    end
  end

  def destroy
    respond_to do |format|
      if @folder
        @parent_id = @folder.parent_id
        if @folder.destroy
          @deleted = true
          @folders = @folder.folder_list_data(params[:object_class].constantize)
          flash.now[:success] = "Folder deleted successfully"
        else
          flash.now[:error] = @folder.errors.full_messages.first
        end
      else
        flash.now[:alert] = "Please select the folder to delete."
      end
      format.js { }
    end
  end

  protected

  def folder_params
    params.require(:folder).permit(:id, :name, :parent_id, :folder_type, :object_class)
  end  

  private
  def find_folder
    @folder = current_account.folders.find_by_id(params[:id])
  end
end
