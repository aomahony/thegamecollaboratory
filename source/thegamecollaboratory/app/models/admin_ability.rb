class AdminAbility
   include CanCan::Ability

   def initialize(user)
      if true == user.is_admin?
         can :access, :rails_admin
         can :manage, :all 
      end
   end

end