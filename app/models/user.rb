class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  extend Auth
  has_secure_password
end
