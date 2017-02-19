class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  extend Auth::Securiy
  has_secure_password
end
