class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at, :updated_at

  belongs_to :user
  belongs_to :post
end