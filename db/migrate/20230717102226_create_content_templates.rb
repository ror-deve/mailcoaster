class CreateContentTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :content_templates do |t|
      t.integer :account_id, null: false
      t.string :name
      t.text :html_part
      t.string :editor_ids
      t.integer :owner_id
      t.string :tag_name
      t.integer :folder_id
      t.text :permissions
      t.timestamps
    end
  end
end
