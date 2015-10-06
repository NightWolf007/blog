class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :surname, :created_at
  attributes :sign_in_count, 
            :current_sign_in_at, 
            :last_sign_in_at,
            :current_sign_in_ip,
            :last_sign_in_ip

  has_many :posts
end