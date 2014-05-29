class Event < ActiveRecord::Base
  
  attr_reader :status_message

  has_many :messages
  belongs_to :user   # make sure this is also specified in the migration that created the tableso the reference field and indexes are created
  validates :url, presence: true

before_validation :generate_url, on: :create 

STATUS=['not accepting Messages at this time.','accepting Messages']


def status_message
  Event::STATUS[self.status]
end


protected

  def generate_url
    self.url = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Event.exists?(url: random_token)
    end
  end

  
end