class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.integer :account_id, null: false
      t.string :name, null: false
      t.boolean :sending_enabled, default: false
      t.boolean :return_path_enabled, default: false
      t.boolean :branded_link_enabled, default: false
      t.boolean :verified, default: false

      t.timestamps
    end

    add_index :domains, [:account_id, :name], unique: true
  end
end
