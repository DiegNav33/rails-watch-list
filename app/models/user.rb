class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_one_attached :profile_picture
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
