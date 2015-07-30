class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    [:nickname, :bio, :timezone].each do |field|
      devise_parameter_sanitizer.for(:account_update) << field
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
