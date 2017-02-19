module Auth
  module Security 
	  def authenticate_by_token(user_token)
	    @auth_object = Auth::AuthObject.new
	    @auth_object.user = find_by(token: md5_hash(token(user_token)))
	    @auth_object
	  end

    private

    def token(user_token)
      begin
        JWT.decode user_token, nil, false
      rescue JWT::ExpiredSignature
        @auth_object.status = :unauthorized
        @auth_object.user_authenticated = false
      rescue JWT::DecodeError
        @auth_object.status = :unauthorized
        @auth_object.user_authenticated = false
      rescue TokenError => error
        @auth_object.status = :unauthorized
        @auth_object.user_authenticated = false
      end
    end

    def md5_hash(decoded_token)
      decoded_token.each do |i|
        return i['md5'] if i.has_key?('md5')
      end
      @status = :unauthorized
      @user_authenticated = false
    end
  end
end
