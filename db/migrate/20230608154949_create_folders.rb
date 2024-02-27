class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :account_id
      t.string :folder_type
      t.text :owner_ids
      t.text :editor_ids
      t.boolean :owner_access, default: true
      t.boolean :editor_access, default: true

      t.timestamps
    end
  end
end
