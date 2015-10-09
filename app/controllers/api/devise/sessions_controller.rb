class Api::Devise::SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
	data = {}
	data[:user] = ActiveModel::SerializableResource.new(self.resource).serializable_hash
	data[:auth_token] = self.resource.authentication_token
	data[:user_email] = self.resource.email
        render json: data, status: 201
      end
    end
  end
end
