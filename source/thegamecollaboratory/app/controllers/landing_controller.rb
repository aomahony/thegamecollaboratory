class LandingController < ApplicationController
   
   protect_from_forgery with: :null_session

   # GET
   def index
   end

   # POST
   def submit
      emailAddress = params[:email_list][:email]
      memberInfo = @mc.lists.member_info @mcNewsletterList['id'], [{'email' => emailAddress}]

      print memberInfo

      status = :ok
      if 0 == memberInfo['success_count'] or 'unsubscribed' == memberInfo['data'][0]['status']
         begin
            @mc.lists.subscribe @mcNewsletterList['id'], {:email => emailAddress}, nil, 'html', false, true, false, true
            EmailList.create(:email => emailAddress)
            message = "Thank you for signing up, #{emailAddress}!"
         rescue => exception
            message = exception.message
            status = :unprocessable_entity
         end
      else
         message = "You've already signed up, #{emailAddress}, but thanks for signing up again! :)"
      end

      render json: {:message => message}, status: status
   end

=begin
   # GET, POST
   def unsubscribe
      if true == request.post?
         emailAddress = params[:email_list][:email]
         existingEmail = EmailList.find_by :email => emailAddress

         status = :ok
         if nil == existingEmail
            status = :unprocessable_entity
         else
            existingEmail.is_active = false
            existingEmail.save
         end

         render json: {:message => message}, status: status
      else

      end
   end

   # GET
   def remove
      emailObject = EmailList.find_by :unique_hash => params[:hash]

      if nil == emailObject
         @message = "E-Mail address not found!"
      else
         emailObject.is_active = false
         emailObject.save

         @message = "#{emailObject.email} has been removed from our e-mail list"
      end
   end

   private
      def email_list_params
         params.require(:email_list).permit(:email)
      end   
=end
end
