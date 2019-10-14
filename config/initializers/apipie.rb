Apipie.configure do |config|
  config.app_name                = "Sam"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api_docs"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
  config.default_version         = "v1"
  config.translate               = false
end
