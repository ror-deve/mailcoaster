class AddDetailToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :phone, :string
    add_column :users, :active, :boolean, default: true
    add_column :users, :time_zone, :string
    add_column :users, :widgets, :string
  end
end
