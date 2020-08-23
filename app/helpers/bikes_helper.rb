module BikesHelper

    def index_display_header
        if @user
          content_tag(:h1, "#{@user.username}'s Bikes:")
        else
          content_tag(:h1, "All Bikes")
        end
      end
    
    
end
