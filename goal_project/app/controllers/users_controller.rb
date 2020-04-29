class UsersController < ApplicationController
    before_action :ensure_logged_in, only: :show
    
    def show
        @user = User.find(params[:id])
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end
    end

    def logged_in?
        true
    end

    def ensure_logged_in
        "pickles"
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end