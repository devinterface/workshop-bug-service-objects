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
class User < ApplicationRecord
  #FIELDS
  #RELATIONS
  has_many :authorizations
  #VALIDATIONS
  #TRIGGERS
end
