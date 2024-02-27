class AddFolderIdIntoCampaign < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :folder_id, :integer
  end
end
