class LandingController < ApplicationController
   
   protect_from_forgery with: :null_session

   # GET
   def index
   end

   # POST
   def submit
      existingEmail = EmailList.find_by :email => params[:email_list][:email]

      status = :ok
      if nil == existingEmail
         begin
            EmailList.create! email_list_params
            message = "Thank you for signing up #{params[:email_list][:email]}!"
         rescue => exception
            message = exception.message
            status = :unprocessable_entity
         end
      else
         message = "You've already signed up, but thanks for signing up again! :)"
      end

      render json: {:message => message}, status: status
   end

   # GET
   def remove
   end

   private
      def email_list_params
         params.require(:email_list).permit(:email)
      end   
end
