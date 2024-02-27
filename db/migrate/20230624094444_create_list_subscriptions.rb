class CreateListSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :list_subscriptions do |t|
      t.integer :account_id, null: false
      t.integer :list_id
      t.integer :contact_id
      t.boolean :active,      default: true
      t.integer :status,      default: 0, limit: 2
      t.timestamps
    end
    change_column :list_subscriptions, :id, 'BIGINT'

    add_index :list_subscriptions, :list_id
    add_index :list_subscriptions, :contact_id
    add_index :list_subscriptions, :active
    add_index :list_subscriptions, :created_at
    add_index :list_subscriptions, [:list_id, :contact_id], unique: true, name: :combined_unique_index
    add_index :list_subscriptions, :status
    add_index :list_subscriptions, [:active, :contact_id]
    add_index :list_subscriptions, [:updated_at, :contact_id]
  end
end
