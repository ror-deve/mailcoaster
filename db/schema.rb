# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_02_14_135627) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.string "address"
    t.string "language"
    t.boolean "active", default: true
    t.string "logo"
    t.string "website"
    t.string "city"
    t.string "state"
    t.integer "alloted_emails", default: 0
    t.integer "sends_count", default: 0
    t.string "link_tracking_domain"
    t.string "dkim_domain"
    t.string "account_type"
    t.string "footer_link"
    t.string "account_subscription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_accounts_on_name", unique: true
    t.index ["owner_id"], name: "index_accounts_on_owner_id"
    t.index ["parent_id"], name: "index_accounts_on_parent_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "campaign_bounces", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "contact_id"
    t.integer "campaign_id"
    t.string "smtp_error", limit: 100
    t.string "diagnostic"
    t.boolean "hard_bounce", default: false
    t.boolean "blocked"
    t.string "spreader_ip", limit: 15
    t.datetime "created_at"
    t.index ["blocked"], name: "index_campaign_bounces_on_blocked"
    t.index ["campaign_id"], name: "index_campaign_bounces_on_campaign_id"
    t.index ["contact_id"], name: "index_campaign_bounces_on_contact_id"
    t.index ["created_at"], name: "index_campaign_bounces_on_created_at"
    t.index ["hard_bounce"], name: "index_campaign_bounces_on_hard_bounce"
    t.index ["spreader_ip", "blocked"], name: "index_campaign_bounces_on_spreader_ip_and_blocked"
    t.index ["spreader_ip"], name: "index_campaign_bounces_on_spreader_ip"
  end

  create_table "campaign_clicks", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "contact_id"
    t.integer "campaign_id"
    t.integer "content_url_id"
    t.string "browser", limit: 150
    t.string "url"
    t.string "ip_address", limit: 15
    t.datetime "recorded_at"
    t.index ["campaign_id"], name: "index_campaign_clicks_on_campaign_id"
    t.index ["contact_id", "recorded_at"], name: "index_campaign_clicks_on_contact_id_and_recorded_at"
    t.index ["contact_id"], name: "index_campaign_clicks_on_contact_id"
    t.index ["recorded_at"], name: "index_campaign_clicks_on_recorded_at"
    t.index ["url"], name: "index_campaign_clicks_on_url"
  end

  create_table "campaign_opens", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "contact_id"
    t.integer "campaign_id"
    t.string "browser"
    t.string "ip_address", limit: 50
    t.datetime "recorded_at"
    t.index ["campaign_id"], name: "index_campaign_opens_on_campaign_id"
    t.index ["contact_id", "campaign_id"], name: "index_campaign_opens_on_contact_id_and_campaign_id"
    t.index ["contact_id", "recorded_at"], name: "index_campaign_opens_on_contact_id_and_recorded_at"
    t.index ["contact_id"], name: "index_campaign_opens_on_contact_id"
    t.index ["recorded_at"], name: "index_campaign_opens_on_recorded_at"
  end

  create_table "campaign_sends", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "contact_id"
    t.integer "campaign_id"
    t.string "spreader_ip", limit: 15
    t.datetime "created_at"
    t.index ["campaign_id"], name: "index_campaign_sends_on_campaign_id"
    t.index ["contact_id", "campaign_id"], name: "index_campaign_sends_on_contact_id_and_campaign_id"
    t.index ["contact_id", "created_at"], name: "index_campaign_sends_on_contact_id_and_created_at"
    t.index ["contact_id"], name: "index_campaign_sends_on_contact_id"
    t.index ["created_at"], name: "index_campaign_sends_on_created_at"
  end

  create_table "campaign_unsubscribes", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "contact_id"
    t.integer "list_id"
    t.integer "campaign_id"
    t.string "reason", limit: 2
    t.datetime "created_at"
    t.index ["campaign_id"], name: "index_campaign_unsubscribes_on_campaign_id"
    t.index ["contact_id"], name: "index_campaign_unsubscribes_on_contact_id"
    t.index ["created_at"], name: "index_campaign_unsubscribes_on_created_at"
    t.index ["list_id", "reason"], name: "index_campaign_unsubscribes_on_list_id_and_reason"
    t.index ["list_id"], name: "index_campaign_unsubscribes_on_list_id"
    t.index ["reason"], name: "index_campaign_unsubscribes_on_reason"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name", null: false
    t.integer "account_id"
    t.integer "content_id"
    t.integer "content_history_id"
    t.string "from_email", limit: 2000
    t.string "subject", limit: 2000
    t.string "reply_to", limit: 2000
    t.string "from_name", limit: 2000
    t.string "preheader", limit: 2000
    t.datetime "send_at"
    t.datetime "sent_at"
    t.string "status", limit: 20
    t.string "language", limit: 2
    t.text "address"
    t.integer "contacts_count"
    t.string "recurring"
    t.datetime "recurring_time"
    t.boolean "test_campaign", default: false
    t.integer "campaign_type", default: 1
    t.boolean "email_preview_link", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "folder_id"
    t.text "html_part"
    t.index ["content_id"], name: "index_campaigns_on_content_id"
    t.index ["created_at"], name: "index_campaigns_on_created_at"
    t.index ["name"], name: "index_campaigns_on_name", unique: true
    t.index ["sent_at"], name: "index_campaigns_on_sent_at"
    t.index ["status"], name: "index_campaigns_on_status"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "domain_name_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "email"], name: "index_contacts_on_account_id_and_email", unique: true
    t.index ["created_at"], name: "index_contacts_on_created_at"
    t.index ["domain_name_id"], name: "index_contacts_on_domain_name_id"
  end

  create_table "content_histories", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "content_id", null: false
    t.integer "campaign_id", null: false
    t.string "name", limit: 150
    t.text "html_part"
    t.text "text_part"
    t.string "footer_type", limit: 20, default: "Default Footer"
    t.integer "footer_id"
    t.datetime "created_at"
    t.index ["campaign_id"], name: "index_content_histories_on_campaign_id"
    t.index ["content_id"], name: "index_content_histories_on_content_id"
  end

  create_table "content_images", force: :cascade do |t|
    t.integer "account_id"
    t.integer "folder_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_templates", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name"
    t.text "html_part"
    t.string "editor_ids"
    t.integer "owner_id"
    t.string "tag_name"
    t.integer "folder_id"
    t.text "permissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name", limit: 150, null: false
    t.text "html_part"
    t.text "text_part"
    t.integer "content_template_id"
    t.string "pull_url"
    t.string "footer_type", limit: 20, default: "Default Footer"
    t.integer "footer_id"
    t.integer "content_feed_id"
    t.boolean "full_email", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "folder_id"
    t.index ["content_template_id"], name: "index_contents_on_content_template_id"
    t.index ["created_at"], name: "index_contents_on_created_at"
    t.index ["name"], name: "index_contents_on_name", unique: true
  end

  create_table "dkim_settings", force: :cascade do |t|
    t.integer "dns_record_id", null: false
    t.string "domain", null: false
    t.string "selector", null: false
    t.string "private_key_path", null: false
    t.string "canonicalization", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_dkim_settings_on_account_id"
    t.index ["domain"], name: "index_dkim_settings_on_domain"
  end

  create_table "dns_records", force: :cascade do |t|
    t.integer "domain_id", null: false
    t.integer "record_type", null: false
    t.string "hostname", null: false
    t.string "value", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id", "hostname"], name: "index_dns_records_on_domain_id_and_hostname"
  end

  create_table "domains", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name", null: false
    t.boolean "sending_enabled", default: false
    t.boolean "return_path_enabled", default: false
    t.boolean "branded_link_enabled", default: false
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "name"], name: "index_domains_on_account_id_and_name", unique: true
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.integer "account_id"
    t.string "folder_type"
    t.text "owner_ids"
    t.text "editor_ids"
    t.boolean "owner_access", default: true
    t.boolean "editor_access", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_folders_on_ancestry"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "account_id", null: false
    t.string "email"
    t.string "roles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "list_subscriptions", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "list_id"
    t.integer "contact_id"
    t.boolean "active", default: true
    t.integer "status", limit: 2, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active", "contact_id"], name: "index_list_subscriptions_on_active_and_contact_id"
    t.index ["active"], name: "index_list_subscriptions_on_active"
    t.index ["contact_id"], name: "index_list_subscriptions_on_contact_id"
    t.index ["created_at"], name: "index_list_subscriptions_on_created_at"
    t.index ["list_id", "contact_id"], name: "combined_unique_index", unique: true
    t.index ["list_id"], name: "index_list_subscriptions_on_list_id"
    t.index ["status"], name: "index_list_subscriptions_on_status"
    t.index ["updated_at", "contact_id"], name: "index_list_subscriptions_on_updated_at_and_contact_id"
  end

  create_table "lists", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "name", null: false
    t.text "address"
    t.string "language", limit: 2
    t.string "from_name"
    t.string "from_email"
    t.string "reply_to_email"
    t.integer "contacts_count", default: 0
    t.boolean "add_to_unsubscribe_page", default: false
    t.datetime "refreshed_at"
    t.integer "subscribers"
    t.integer "unsubscribes"
    t.integer "soft_bounces"
    t.integer "hard_bounces"
    t.string "post_url"
    t.string "list_type", limit: 20, default: "normal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_lists_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.string "country"
    t.string "state"
    t.string "phone"
    t.boolean "active", default: true
    t.string "time_zone"
    t.string "widgets"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
