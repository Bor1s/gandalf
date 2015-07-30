class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_timezone

  private

  def set_locale
    I18n.locale = params[:l].presence || :ru
  end

  def set_timezone
    default_timezone = Time.zone
    if current_user and current_user.timezone.present?
      Time.zone = current_user.timezone
    else
      Time.zone = default_timezone
    end
  end
end
