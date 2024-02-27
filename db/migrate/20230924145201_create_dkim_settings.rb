class CreateDkimSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :dkim_settings do |t|
      t.integer :dns_record_id, null: false
      t.string :domain, null: false
      t.string :selector, null: false
      t.string :private_key_path, null: false
      t.string :canonicalization, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
