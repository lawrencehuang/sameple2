# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password   

  # before_save { |user| user.email = email.downcase }
  before_save {self.email = self.email.downcase}
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence:true, length: {within: 3..50}
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX},
  					 				uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }				
  validates :password_confirmation, presence: true			

  # validates_presence_of :name, :on => :create, :message => "can't be blank"
  # validates_length_of :name, :within => 3..50, :on => :create, :message => "Maximum length is 50"
  # validates_presence_of :email, :on => :create, :message => "can't be blank"
  # validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, 
  # 										:on => :create, :message => "is invalid"
  # validates_uniqueness_of :email, :case_sensitive => false, 
  # 												:on => :create, :message => "must be unique"

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
