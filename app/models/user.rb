class User < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :surname, presence: true

  has_many :posts
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
          # :confirmable,
          :recoverable,
          :registerable,
          :rememberable,
          :trackable,
          :timeoutable,
          :validatable

  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def is_admin?
    return is_admin
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).exists?
      end
    end
end
