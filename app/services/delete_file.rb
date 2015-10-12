class DeleteFile

  FILES_DIR = Rails.root

  def initialize(filename)
    @filename = context
  end

  def execute
    begin
      File.delete("#{self.class::FILES_DIR}/#{@filename}")
    rescue Errno::ENOENT
    end
  end
end