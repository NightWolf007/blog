class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :comments

  def img
    "#{ENV['SERVER_BASE_URL']}/images/#{image}" if image
  end
end