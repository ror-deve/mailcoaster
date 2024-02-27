class CreateCampaignBounces < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_bounces, id: false do |t|
      t.integer :account_id, null: false
      t.integer :contact_id
      t.integer :campaign_id
      t.string :smtp_error, limit: 100
      t.string :diagnostic
      t.boolean :hard_bounce, default: false
      t.boolean :blocked
      t.string :spreader_ip, limit: 15
      t.datetime :created_at
    end
    add_index :campaign_bounces, :contact_id
    add_index :campaign_bounces, :campaign_id
    add_index :campaign_bounces, :blocked
    add_index :campaign_bounces, :spreader_ip
    add_index :campaign_bounces, :created_at
    add_index :campaign_bounces, :hard_bounce
    add_index :campaign_bounces, [:spreader_ip, :blocked]
  end
end
