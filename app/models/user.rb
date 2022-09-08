class User < ApplicationRecord
  has_many :organized_surveys, class_name: "Survey", dependent: :destroy
  has_many :completions
  has_many :completed_surveys, through: :completions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   def to_s
    "#{username}"
   end

   def full_name
    "#{first_name} #{last_name}"           
   end

end
