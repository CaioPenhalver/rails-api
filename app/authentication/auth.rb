module Auth
  def authenticate_by_token(user_token)
    find_by(token: md5_hash(token(user_token)))
  end

  private

  def token(user_token)
    begin
      JWT.decode user_token, nil, false
    rescue JWT::ExpiredSignature
      raise TokenError.new('Token expired', :unauthorized)
    rescue JWT::DecodeError
      raise TokenError.new('Authentication failed', :bad_request)
    rescue TokenError => error
      raise error
    end
  end

  def md5_hash(decoded_token)
    decoded_token.each do |i|
      return i['md5'] if i.has_key?('md5')
    end
    raise TokenError('Authentication failed', :unauthorized)
  end

end
