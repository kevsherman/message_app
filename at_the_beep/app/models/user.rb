class User < ActiveRecord::Base
  has_many :events
  has_many :messages, through: :events

  validates :email, uniqueness: true
  validates :firstname, length:{minimum: 2}
  validates :lastname, length:{minimum: 2}
  # validates :password, length:{minimum: 6}

end
