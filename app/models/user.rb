class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  before_save :ensure_api_key

  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :checkings

  def ensure_api_key
    if api_key.blank?
      self.api_key = generate_api_key
    end
  end

  private

  # Generate a unique API key
  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end
end
