class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.integer :account_id,      null: false
      t.string :name,             null: false, limit: 150
      t.text :html_part,          limit: (16.megabytes - 1)
      t.text :text_part
      t.integer :content_template_id
      t.string :pull_url
      t.string :footer_type,      limit: 20, default: 'Default Footer'
      t.integer :footer_id
      t.integer :content_feed_id
      t.boolean :full_email,      default: false

      t.timestamps
    end

    add_index :contents, :name, unique: true
    add_index :contents, :created_at
    add_index :contents, :content_template_id
  end
end
