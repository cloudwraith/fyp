class UsersController < ApplicationController


  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])

  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to PAGE!"
      redirect_to @user     #Could have used redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def index
    redirect_to signup_path
  end
### PRIVATE METHODS START FROM HERE ###

  private

    def user_params
      params.require(:user).permit(:name, :email, :age, :password, :password_confirmation)
    end


end
