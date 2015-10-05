class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :created_at, :updated_at, :img
  
  belongs_to :user
  
  has_many :tags
  has_many :comments
end