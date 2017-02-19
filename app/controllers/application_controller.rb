class ApplicationController < ActionController::API

  private

  def authenticate
    auth_object = User.authenticate_by_token(params[:token])
    if !auth_object.user_authenticated? 
      render json: {msg: 'Authentication failed'}, status: auth_object.status
    end
  end
end
