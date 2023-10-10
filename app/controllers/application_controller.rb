class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token, only: :toggle
    include SessionsHelper
        private
       
        def logged_in_user
        unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
        end
        end

end
