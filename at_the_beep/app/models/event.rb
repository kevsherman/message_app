class Event < ActiveRecord::Base
  has_many :messages
  belongs_to :user
  validates :url, presence: true

before_validation : generate_url, on :create 

  protected

  def generate_url
    self.url = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Event.exists?(url: random_token)
    end
  end
  
end