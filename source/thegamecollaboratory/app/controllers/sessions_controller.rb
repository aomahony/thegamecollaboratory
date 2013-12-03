class SessionsController < Devise::SessionsController

   def after_sign_in_path_for(resource)
      stored_location_for(resource) ||
         if resource.is_a?(User) and resource.is_admin?
            rails_admin.dashboard_path
         else
            root_path
         end
   end

end