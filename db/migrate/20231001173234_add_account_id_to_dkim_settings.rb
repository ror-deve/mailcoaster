class AddAccountIdToDkimSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :dkim_settings, :account_id, :integer
    add_index :dkim_settings, :account_id
    add_index :dkim_settings, :domain
  end
end
