class SessionsController < ApplicationController
    def create
        @user = User.find_by(email: session_params[:email])
      
        if @user && @user.authenticate(session_params[:password])
          login!
          render json: {
            logged_in: true,
            user: @user
          }
        else
          render json: { 
            status: 401,
            errors: ['Les informations entrées ne correspondent à aucun compte']
          }
        end
      end
    def is_logged_in?
        if logged_in? && current_user
          render json: {
            logged_in: true,
            user: current_user
          }
        else
          render json: {
            logged_in: false,
            message: 'Vous n''êtes pas connecté'
          }
        end
      end
    def destroy
        logout!
        render json: {
          status: 200,
          logged_out: true
        }
      end
    private
    def session_params
        params.require(:user).permit( :email, :password)
      end
    end