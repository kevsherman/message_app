class User < ActiveRecord::Base
  has_many :events, dependant: :destroy
  has_many :messages, through: :events

  validates :email, uniqueness: true
  validates :firstname, length:{minimum: 2}
  validates :lastname, length:{minimum: 2}
  validates :phone, numericality:{only_integer: true}
  # validates :password, length:{minimum: 6}

end
