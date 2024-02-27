class ListImportWorker
  include Sidekiq::Worker

  def perform(file_path, attributes, account_id, options={})
    import_service = ListImportService.new(file_path, attributes, account_id, options)
    import_service.import_contact
  end
end
