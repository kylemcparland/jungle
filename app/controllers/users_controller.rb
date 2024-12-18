class UsersController < ApplicationController

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, presence: true, on: :create
  
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
