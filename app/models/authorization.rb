# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :string
#  key        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authorization < ApplicationRecord
  #FIELDS
  #RELATIONS
  belongs_to :user
  #VALIDATIONS
  validates :provider, :key, presence: true
  #TRIGGERS
end
