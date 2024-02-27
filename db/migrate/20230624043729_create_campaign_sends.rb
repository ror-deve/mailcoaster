class CreateCampaignSends < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_sends, id: false do |t|
      t.integer :account_id, null: false
      t.integer :contact_id
      t.integer :campaign_id
      t.string  :spreader_ip,         limit: 15
      t.datetime :created_at
    end

    add_index :campaign_sends, :contact_id
    add_index :campaign_sends, :campaign_id
    add_index :campaign_sends, :created_at
    add_index :campaign_sends, [:contact_id, :created_at]
    add_index :campaign_sends, [:contact_id, :campaign_id]
  end
end
