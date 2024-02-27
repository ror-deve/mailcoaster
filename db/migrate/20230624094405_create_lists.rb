class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.integer :account_id,  null: false
      t.string :name, null: false
      t.text :address
      t.string :language, limit: 2
      t.string :from_name
      t.string :from_email
      t.string :reply_to_email
      t.integer :contacts_count, default: 0
      t.boolean :add_to_unsubscribe_page, default: false
      t.datetime :refreshed_at
      t.integer :subscribers
      t.integer :unsubscribes
      t.integer :soft_bounces
      t.integer :hard_bounces
      t.string :post_url
      t.string :list_type, default: 'normal', limit: 20

      t.timestamps
    end

    add_index :lists, :name, unique: true
  end
end
