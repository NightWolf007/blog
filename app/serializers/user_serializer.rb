class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :surname, :created_at
  attribute :avatar

  has_many :posts
end