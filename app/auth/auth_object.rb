module Auth
  class AuthObject
    attr_accessor :user_authenticated, 
                  :status,
                  :user

    def user_authenticated?
      @user_authenticated
    end
  end
end

