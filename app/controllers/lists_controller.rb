class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_or_init
  respond_to :json, :xml, :html, :js

  def index
    lists = List.where(account_id: params[:account_id])
    @lists = lists.paginate(page: params[:page])
  end

  def show 
  end

  def new
  end

  def create
    respond_to do |format|
      @list = List.new(lists_params)
      @list.account_id = current_account.id
      if @list.save
        format.html { redirect_to account_lists_path(current_account), notice: 'List was successfully created.' }  
      else
        flash[:error] = @list.errors.full_messages
        format.html { render action: 'new' }  
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @list.update(lists_params)
        format.html { redirect_to account_lists_path(current_account), notice: 'List was successfully updated.' }
      else
        flash[:error] = @list.errors.full_messages
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @list.destroy
        flash[:success] = "List was successfully deleted."
        format.js { render js: "window.location = '#{account_lists_path(current_account)}'" }
      end
    end    
  end

  def import
    respond_to do |format|
      format.js
    end
  end

  def upload_csv
    begin
      file = params[:csv_file]
      is_valid, messsage = List.validate_file(file)
      unless is_valid
        redirect_to account_lists_path(current_account), alert: "Invalid File ! #{message}"
      end

      file_path = List.read_and_save_file(current_account.id, @list.id, file)

      # mapping csv values
      model_attributes = {
        'first_name' => "first_name",
        'last_name' => "last_name", 
        'email' => "email",
      }

      options = {
        "list_id" => @list.id,
        "content_type" => file.content_type
      }

      ListImportWorker.perform_async(file_path, model_attributes, current_account.id, options)
      redirect_to account_lists_path(current_account), notice: "Contacts are being processed. Import process will start shortly."
    rescue StandardError => e
      redirect_to account_lists_path(current_account), alert: "An error occurred: #{e.message}"
    end
  end

  private 
  def lists_params
    params.require(:list).permit(:name, 
      :language, :from_name, :from_email, :reply_to_email, 
      :list_type, :add_to_unsubscribe_page, :address, 
      :post_url
    )
  end

  def find_or_init
    @list = List.find_by(id: params[:id], account_id: current_account.id)
    if @list.blank?
      @list = List.new()
    end
    return @list
  end

end
