class NewsletterMailer < ActionMailer::Base
   default from: "donotreply@thegamecollaboratory.com"

   def execute(newsletter, user, subject)

   end
end
