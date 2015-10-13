class DeleteImage < DeleteFile
  FILES_DIR = Rails.root.join ENV['IMAGES_DIR']
end