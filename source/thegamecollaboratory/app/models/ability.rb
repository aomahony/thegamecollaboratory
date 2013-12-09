class Ability
   include CanCan::Ability

   def initialize(user)

      if true == user.is_active?
         if true == user.is_admin?
            can :manage, :all
         else
            can :read, :all
            can :create, [Game, Comment]
            can [:update, :destroy], Game, :user_id => user.id
            can [:update, :destroy], Comment, :user_id => user.id
         end
      else
         can :manage, User, :user_id => user.id
      end

   end
end
