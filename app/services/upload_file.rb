class UploadFile

  MAX_SIZE = 10 * 1024 *1024
  ALLOWED_FORMATS = []
  FILES_DIR = Rails.root

  def initialize(context, file)
    @context, @file = context, file
  end

  def execute
    @context.upload_success upload(@image) if validate
  end

  def validate
    unless @file.size <= self.class::MAX_SIZE
      @context.upload_entity_too_large MAX_SIZE
      return false
    end
    
    filetype = File.extname @file.original_filename
    unless self.class::ALLOWED_FORMATS.empty? || self.class::ALLOWED_FORMATS.include?(filetype)
      @context.upload_unsupported_media_type filetype
      return false
    end
    return true
  end

  def upload(file)
    filename = "#{SecureRandom.hex(5)}#{File.extname @file.original_filename}"

    file = @file.read
    File.open("#{self.class::FILES_DIR}/#{filename}", 'wb') do |f|
      f.write file
    end

    return filename
  end
end