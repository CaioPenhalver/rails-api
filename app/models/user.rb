class User < ApplicationRecord
  include ActiveModel::Serializers::JSON
  has_secure_password
end
