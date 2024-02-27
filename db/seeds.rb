# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

admin_user = AdminUser.where(email: 'admin@mailcoaster.com').first_or_create(password: 'Master123#', password_confirmation: 'Master123#')
puts "> Admin User:"
puts "> Email: admin@mailcoaster.com"
puts "> Password: Master123#"
puts ""

user = User.where(email: 'coder@mailcoaster.com').first_or_create(username: 'coder', password: 'Master123#', password_confirmation: 'Master123#')
puts "> User:"
puts "> Email: coder@mailcoaster.com"
puts "> Password: Master123#"
puts ""

account = Account.create!(name: "Dummy Account - #{rand(10)}",
  address: 'sample address',
  owner_id: user.id,
  website: 'mailcoster.com',
  city: 'melbourne',
  state: 'Victoria',
  account_type: 'dedicated',
  account_subscription: 'yearly'
)

puts "> Account: #{account.name}"

["campaign", "content", "content_image", "content_template"].each do |model|
  Folder.create(name: "my_#{model}", account_id: account.id, folder_type: "#{model}")
end
