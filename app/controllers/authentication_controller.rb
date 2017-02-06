class AuthenticationController < ApplicationController

  def create
    user = User.find_by(email: auth_params[:email])
    if !user.nil? && user.authenticate(auth_params[:password])
      md5_hash = Digest::MD5.new
      md5_hash.update user.email
      exp = Time.now.to_i + 7 * 3600
      payload = { md5: md5_hash, exp: exp }
      token = JWT.encode payload, nil, 'none'
      user.token = md5_hash
      if user.save
        render json: { token: token}
      else
        render json: { error: "Sorry, an error has ocurred!" }
      end
    else
      render json: { error: "Authentication failed" }
    end
  end


  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
