class ContentImagesController < InheritedResources::Base
  before_action :authenticate_user!
  respond_to :json, :xml, :html, :js

  def new
    @new_content_image = current_account.content_images.new(folder_id: params[:folder_id])
  end

  def create
    respond_to do |format|
      if params[:content_images].present?
        params[:content_images].each do |ci|
          content_image = current_account.content_images.new(content_image_params)
          content_image.image = ci
          content_image.save
          flash.now[:success] = "Images added successfully..!"
        end
        @folder_depth = content_image_params[:folder_depth].present? ? content_image_params[:folder_depth].to_i : 0
        folder_id = content_image_params[:folder_id].present? ? content_image_params[:folder_id] : nil
        @content_images = current_account.content_images.with_folder(folder_id).sorted
      else
        @errors = ["Please add some images to upload..!!!!"]
        flash.now[:error] = @errors
      end
      format.js { }
    end
  end

  def destroy
    @content_image = current_account.content_images.find_by_id(params[:id])
    respond_to do |format|
      if @content_image
        if @content_image.destroy
          @deleted = true
          @folder_depth = params[:folder_depth].present? ? params[:folder_depth].to_i : 0
          folder_id = params[:folder_id].present? ? params[:folder_id] : nil
          @content_images = current_account.content_images.with_folder(folder_id).sorted
          flash.now[:success] = "Content Image deleted successfully"
        else
          flash.now[:error] = @content_image.errors.full_messages.first
        end
      else
        flash.now[:alert] = "Something went wrong.. please try after sometime..!"
      end
      format.js { }
    end
  end

  private
  def content_image_params
    params.require(:content_image).permit(:account_id, :folder_id, :image, :folder_depth)
  end
end
