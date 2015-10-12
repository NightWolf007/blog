class Api::V1::ImagesController < ApplicationController

  before_filter :authenticate_user!

  def create
    unless params.has_key?(:image)
      render status: :bad_request, json: { error: "Form must contain image key" }
      return
    end
    UploadPostImage.new(self, params[:image]).execute
  end

  def upload_success(img_name)
    render json: { url: "#{ENV['SERVER_BASE_URL']}/images/#{img_name}" }
  end

  def upload_entity_too_large(max_size)
    render status: :request_entity_too_large, json: { error: "Image size must be less then #{max_size} bytes" }
  end

  def upload_unsupported_media_type(type)
    render status: :unsupported_media_type, json: { error: "Media type '#{type}' is unsupported" }
  end
end