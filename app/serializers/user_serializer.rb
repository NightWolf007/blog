class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :surname, :created_at

  has_many :posts
end