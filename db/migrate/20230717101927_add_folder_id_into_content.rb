class AddFolderIdIntoContent < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :folder_id, :integer
  end
end
