class User < ActiveRecord::Base
  has_one :map
  has_many :photos

end