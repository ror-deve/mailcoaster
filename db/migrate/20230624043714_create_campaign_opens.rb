class CreateCampaignOpens < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_opens, id: false do |t|
      t.integer :account_id, null: false
      t.integer :contact_id
      t.integer :campaign_id
      t.string :browser
      t.string :ip_address, limit: 50
      t.datetime :recorded_at
    end

    add_index :campaign_opens, :contact_id
    add_index :campaign_opens, :campaign_id
    add_index :campaign_opens, :recorded_at
    add_index :campaign_opens, [:contact_id, :recorded_at]
    add_index :campaign_opens, [:contact_id, :campaign_id]
  end
end
