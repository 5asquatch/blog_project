class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception


    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :avatar) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar) }
        
    end

    


end
