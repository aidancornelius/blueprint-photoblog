class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	
	protected
	
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :display_name, :admin]) #danger zone, admin permitted on post, turn off registerable
		devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :display_name, :admin]) #danger zone, admin permitted on post, turn off registerable
	  end
end
