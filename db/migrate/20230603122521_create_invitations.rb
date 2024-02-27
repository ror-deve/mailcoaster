class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.integer :user_id,       null: false
      t.integer :account_id,    null: false
      t.string :email
      t.string :roles

      t.timestamps
    end

    add_index :invitations, :user_id
  end
end
