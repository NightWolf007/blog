class UploadImage < UploadFile
  ALLOWED_FORMATS = ['.jpg', '.jpeg', '.png', '.gif']
  FILES_DIR = Rails.root.join ENV['IMAGES_DIR']
end