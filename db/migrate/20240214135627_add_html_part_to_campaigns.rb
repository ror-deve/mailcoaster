class AddHtmlPartToCampaigns < ActiveRecord::Migration[7.0]
  def change
    add_column :campaigns, :html_part, :text
  end
end
