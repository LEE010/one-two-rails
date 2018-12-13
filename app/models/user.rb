class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile
  accepts_nested_attributes_for :profile
  acts_as_voter
  acts_as_follower
  acts_as_followable
  has_one :store
  has_many :comments
  has_many :posts
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
