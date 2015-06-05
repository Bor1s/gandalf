class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    [:nickname, :bio].each do |field|
      devise_parameter_sanitizer.for(:account_update) << field
    end
  end

  private

  def set_locale
    I18n.locale = params[:l].presence || :ru
  end
end
