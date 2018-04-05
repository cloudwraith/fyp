class SessionsController < ApplicationController


  	def new
  	end

	def create
	  	user = User.find_by(email: params[:session][:email].downcase)
	    if user && user.authenticate(params[:session][:password])
	      # Log the user in and redirect to the user's show page.
	      log_in user
	      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
	      redirect_back_or user
	    else
	      # Create an error message.
    		flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
    		render 'new'
    	end
  	end

	def destroy
  		log_out if logged_in?
  		redirect_to root_url
  	end

  	# Returns the user corresponding to the remember token cookie.
  	def current_user
    	if (user_id = session[:user_id])
      		@current_user ||= User.find_by(id: user_id)
    	elsif (user_id = cookies.signed[:user_id])
      		user = User.find_by(id: user_id)
      		if user && user.authenticated?(cookies[:remember_token])
        		log_in user
        		@current_user = user
      		end
    	end
  	end
end
