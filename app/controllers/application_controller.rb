class ApplicationController < ActionController::API

  private

  def authenticate
    token = params[:token]
    return render json: {msg: 'Authentication failed 1'} if token.nil?
    decoded_token = nil
    begin
      decoded_token = JWT.decode token, nil, false
    rescue JWT::ExpiredSignature
      return render json: {msg: 'Token expired'}
    rescue JWT::DecodeError
      return render json: {msg: 'Authentication failed 2'}
    end
    md5 = nil
    decoded_token.each { |i| md5 = i['md5'] if i.has_key?('md5')}
    @user = User.find_by(token: md5)
    if @user.nil?
      render json: {msg: 'Authentication failed 3'}
    end
  end
end
