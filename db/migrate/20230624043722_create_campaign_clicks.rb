class CreateCampaignClicks < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_clicks, id: false do |t|
      t.integer :account_id, null: false
      t.integer :contact_id
      t.integer :campaign_id
      t.integer :content_url_id
      t.string :browser, limit: 150
      t.string :url
      t.string :ip_address, limit: 15
      t.datetime :recorded_at
    end
    add_index :campaign_clicks, :contact_id
    add_index :campaign_clicks, :campaign_id
    add_index :campaign_clicks, :url
    add_index :campaign_clicks, :recorded_at
    add_index :campaign_clicks, [:contact_id, :recorded_at]
  end
end
