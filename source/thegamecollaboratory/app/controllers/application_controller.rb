class ApplicationController < ActionController::Base
   # Prevent CSRF attacks by raising an exception.
   # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception

   before_filter :authenticate 

   before_action :setup_mcapi

   def setup_mcapi
      @mc = Mailchimp::API.new('8112dcf6d61202b3baa991f70ad1d437-us3')

      lists = @mc.lists.list
      newsletterId = '6dd33ebf12'

      lists['data'].each do |list|
         if newsletterId == list['id']
            @mcNewsletterList = list
            break
         end
      end
   end

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
