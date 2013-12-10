class EmailList < ActiveRecord::Base

   before_create :create_hash
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

   private
      def create_hash
         self.unique_hash = get_hash
      end

      def get_hash
         Digest::SHA2.hexdigest(self.email + Time.now.getutc.to_s)
      end
end