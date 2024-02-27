class CreateDnsRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :dns_records do |t|
      t.integer :domain_id, null: false
      t.integer :record_type, null: false
      t.string :hostname, null: false
      t.string :value, null: false
      t.boolean :verified, null: false, default: false

      t.timestamps
    end

    add_index :dns_records, [:domain_id, :hostname]
  end
end
