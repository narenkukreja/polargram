class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :comments
  validates :user_name, presence: true, length: {minimum: 5, maximum: 12}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
