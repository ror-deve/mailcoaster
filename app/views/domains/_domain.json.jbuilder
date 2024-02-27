json.extract! domain, :id, :name, :sending_enabled, :return_path_enabled, :branded_link_enabled, :verified, :created_at, :updated_at
json.url domain_url(domain, format: :json)
