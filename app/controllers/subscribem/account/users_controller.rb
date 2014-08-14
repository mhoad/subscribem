require_dependency "subscribem/application_controller"

module Subscribem
  #The book doesn't explicitly say that it should inherit from 
  #Subscribem::ApplicationController but all others under account do
  class Account::UsersController < Subscribem::ApplicationController
    def new
      @user = Subscribem::User.new
    end

    def create
      account = Subscribem::Account.find_by!(:subdomain => request.subdomain)
      user = account.users.create(user_params)
      force_authentication!(account, user)
      flash[:success] = "You have signed up successfully."
      redirect_to root_path
    end

    private
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
  end
end
