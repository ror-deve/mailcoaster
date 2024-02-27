class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :parent_id
      t.integer :owner_id,        null: false
      t.string :name,             null: false
      t.string :address
      t.string :language
      t.boolean :active, default: true
      t.string :logo
      t.string :website
      t.string :city
      t.string :state
      t.integer :alloted_emails, default: 0
      t.integer :sends_count, default: 0
      t.string :link_tracking_domain
      t.string :dkim_domain
      t.string :account_type
      t.string :footer_link
      t.string :account_subscription

      t.timestamps
    end

    add_index :accounts, :name, unique: true
    add_index :accounts, :parent_id
    add_index :accounts, :owner_id
  end
end
