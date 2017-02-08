class ApplicationController < ActionController::API

  private

  def authenticate
    begin
      @user = User.authenticate_by_token(params[:token])
      if @user.nil?
        render json: {msg: 'Authentication failed'}, status: :unauthorized
      end
    rescue TokenError => error
      render json: {msg: error.message}, status: error.http_status
    end
  end
end
