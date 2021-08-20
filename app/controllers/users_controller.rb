class UsersController < ApplicationController
    def create 
        @user = User.new(user_params)

        if @user.save 
            render json: {id: @user.id, username: @user.username
                }, status: 201
        else 
            render json: @user.errors, status: 400
        end 
    end
    
    def update 
        @user = User.find(params[:id])
        begin
            user_params.each do |key, value| 
                @user.update_attribute(key, value)
            end 
            render json: {id: @user.id, username: @user.username}, status: 202
        rescue => exception
            render json: @user.errors, status: 400
        end
    end  

    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end 
end
