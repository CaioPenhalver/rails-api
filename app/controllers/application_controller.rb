class ApplicationController < ActionController::API

  private

  def authenticate
    begin
      @user = User.find_by(token: md5_hash(token))
      if @user.nil?
        render json: {msg: 'Authentication failed'}
      end
    rescue TokenError => msg
      render json: {msg: msg}
    end
  end

  def token
    token = params[:token]
    raise TokenError.new('Authentication failed') if token.nil?
    begin
      JWT.decode token, nil, false
    rescue JWT::ExpiredSignature
      raise TokenError('Token expired')
    rescue JWT::DecodeError
      raise TokenError.new('Authentication failed')
    rescue TokenError
      raise TokenError.new('Authentication failed')
    end
  end

  def md5_hash(decoded_token)
    decoded_token.each do |i|
      return i['md5'] if i.has_key?('md5')
    end
    raise TokenError('Authentication failed')
  end

end
