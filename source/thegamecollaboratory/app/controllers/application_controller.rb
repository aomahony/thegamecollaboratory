class ApplicationController < ActionController::Base
   # Prevent CSRF attacks by raising an exception.
   # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception

   before_filter :authenticate 

   rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_path, :alert => exception.message
   end

   private
      def authenticate
         if params[:controller] != 'landing' and params[:controller] != 'sessions'
            redirect_to(main_app.root_path) unless current_user != nil and current_user.is_admin?
         end
      end
end
