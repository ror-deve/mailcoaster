class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.integer   :account_id,        null: false
      t.string    :email,             null: false
      t.string    :first_name
      t.string    :last_name
      t.integer   :domain_name_id,    null: false

      t.timestamps
    end
    add_index :contacts, [:account_id, :email], unique: true, name: 'index_contacts_on_account_id_and_email'
    add_index :contacts, :created_at
    add_index :contacts, :domain_name_id
  end
end
