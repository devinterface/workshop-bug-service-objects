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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
