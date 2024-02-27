class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :name, null: false
      t.integer :account_id
      t.integer :content_id
      t.integer :content_history_id
      t.string :from_email, limit: 2000
      t.string :subject, limit: 2000
      t.string :reply_to, limit: 2000
      t.string :from_name, limit: 2000
      t.string :preheader, limit: 2000
      t.datetime :send_at
      t.datetime :sent_at
      t.string :status, limit: 20
      t.string :language, limit: 2
      t.text :address
      t.integer :contacts_count
      t.string :recurring
      t.datetime :recurring_time
      t.boolean :test_campaign, default: false
      t.integer :campaign_type, default: 1
      t.boolean :email_preview_link, default: true

      t.timestamps
    end

    add_index :campaigns, :name, unique: true
    add_index :campaigns, :content_id
    add_index :campaigns, :status
    add_index :campaigns, :created_at
    add_index :campaigns, :sent_at
  end
end
