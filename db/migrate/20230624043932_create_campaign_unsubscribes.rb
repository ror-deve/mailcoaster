class CreateCampaignUnsubscribes < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_unsubscribes, id: false do |t|
      t.integer :account_id, null: false
      t.integer :contact_id
      t.integer :list_id
      t.integer :campaign_id
      t.string :reason, limit: 2
      t.datetime :created_at
    end

    add_index :campaign_unsubscribes, :contact_id
    add_index :campaign_unsubscribes, :campaign_id
    add_index :campaign_unsubscribes, :reason
    add_index :campaign_unsubscribes, :list_id
    add_index :campaign_unsubscribes, :created_at
    add_index :campaign_unsubscribes, [:list_id, :reason]
  end
end
