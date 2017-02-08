class TokenError < StandardError
  attr_accessor :http_status, :message
  def initialize(message = 'Token error', http_status)
    @message = message
    @http_status = http_status
  end
end
