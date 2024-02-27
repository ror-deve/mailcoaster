class CreateContentImages < ActiveRecord::Migration[7.0]
  def change
    create_table :content_images do |t|
      t.integer :account_id
      t.integer :folder_id
      t.string :image

      t.timestamps
    end
  end
end
