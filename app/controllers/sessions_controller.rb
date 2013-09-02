class SessionsController < ApplicationController

    def index

    end  
      

    def create
        @user = User.from_omniauth(env["omniauth.auth"])
       
        session[:user_id] = @user.id
        
         redirect_to user_locations_path(@user.id) , notice: "Signed in!!"
    end

    def destroy
      session[:user_id] = nil
      redirect_to "/"
    end

    def show
      
       
    end


end




