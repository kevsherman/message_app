class Event < ActiveRecord::Base
  has_many :messages
  belongs_to :user


  
end