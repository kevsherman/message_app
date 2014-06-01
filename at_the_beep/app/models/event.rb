class Event < ActiveRecord::Base
  
  attr_reader :status_message

  has_many :messages
  belongs_to :user   # make sure this is also specified in the migration that created the tableso the reference field and indexes are created
  validates :url, presence: true
  validates :name, presence: true, length: {minimum: 4}

before_validation :generate_url, on: :create 

def check_status
  self.date == Date.today
end

protected

  def generate_url
    self.url = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Event.exists?(url: random_token)
    end
  end

  
end