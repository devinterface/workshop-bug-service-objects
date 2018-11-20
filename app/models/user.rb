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
  attr_accessor :password, :facebook_token, :registration_type
  #RELATIONS
  has_many :authorizations
  #VALIDATIONS
  validates :email, presence: true
  validates :password, presence: true, if: :email_registration? 
  validates :facebook_token, presence: true, if: :facebook_registration?

  #TRIGGERS

  def handle_email_registration
    ActiveRecord::Base.transaction do
      generate_password_hash
      generate_activation_token
      save
      create_jwt_authorization
      send_activation_email
    end
  end

  def handle_facebook_registration
    ActiveRecord::Base.transaction do
      save
      create_jwt_authorization
      create_facebook_authorization
    end
  end

  private

  def email_registration?
    registration_type == 'email'
  end

  def facebook_registration?
    registration_type == 'facebook'
  end

  def generate_password_hash
    self.hashed_password = BCrypt::Password.create(password)
  end

  def generate_activation_token
    self.activation_token = SecureRandom.hex
  end

  def create_jwt_authorization
    self.authorizations.create(provider: 'jwt', key: SecureRandom.hex)
  end

  def create_facebook_authorization
    self.authorizations.create(provider: 'facebook', key: facebook_token)
  end

  def send_activation_email
    ActivationMailer.send_activation_email(email, activation_token).deliver_now
  end
  
end
