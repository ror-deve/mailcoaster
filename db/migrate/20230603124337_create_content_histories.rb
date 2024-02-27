class CreateContentHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :content_histories do |t|
      t.integer :account_id,    null: false
      t.integer :content_id,    null: false
      t.integer :campaign_id,   null: false
      t.string :name,           limit: 150
      t.text :html_part,        limit: (16.megabytes - 1)
      t.text :text_part
      t.string :footer_type,    limit: 20, default: 'Default Footer'
      t.integer :footer_id
      t.datetime :created_at
    end

    add_index :content_histories, :content_id
    add_index :content_histories, :campaign_id
  end
end
