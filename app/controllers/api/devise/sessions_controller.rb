class Api::Devise::SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        render json: {user: self.resource}, status: 201
      end
    end
  end
end