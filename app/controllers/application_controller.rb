class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  def current_ability
    if admin_signed_in?
      @current_ability ||= Ability.new(current_admin)
    else
      @current_ability ||= Ability.new(current_user)
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :gender, :birthday, :password,
        :password_confirmation).merge role: User.roles[:manager]
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :name, :email, :gender, :birthday, :password,
        :password_confirmation, :current_password, :avatar
    end
  end
end
