class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

   has_many :games
   has_many :comments

   def is_super?
      2 == self.role.to_i ? true : false
   end

   def is_admin?
      1 <= self.role.to_i ? true : false
   end

   def role_name
      if '0' == self.role
         'Public'
      elsif '1' == self.role
         'Administrator'
      elsif '2' == self.role
         'Super Administrator'
      end
   end

   def full_name
      "#{self.first_name} #{self.last_name}"
   end

   protected
      def confirmation_required?
        !self.is_admin?
      end        
end
