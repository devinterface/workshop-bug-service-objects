# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string
#  hashed_password  :string
#  active           :boolean          default(FALSE)
#  activation_token :string
#  activated_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'bcrypt'

class User < ApplicationRecord
  #FIELDS
  attr_accessor :password
  #RELATIONS
  has_many :authorizations
  #VALIDATIONS
  validates :email, presence: true
  validates :password, presence: true, on: :create

  #TRIGGERS
  before_create :generate_hash
  before_create :generate_activation_token
  after_create :create_jwt_authorization
  after_create :send_activation_email

  private

  def generate_hash
    self.hashed_password = BCrypt::Password.create(password)
  end

  def generate_activation_token
    self.activation_token = SecureRandom.hex
  end

  def create_jwt_authorization
    self.authorizations.create(provider: 'jwt', key: SecureRandom.hex)
  end

  def send_activation_email
    ActivationMailer.send_activation_email(email, token).deliver_now
  end
  
end
