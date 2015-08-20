require 'test_helper'

class AmbassadorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  base_ambas_params = {fname:'Matthew', lname:'Vasseur', status:'registered',
  email: 'tester@com.com', phone:'5557775577', street: '9 Test Lane', state: 'NJ',
  city: 'Testtown', zip: '06576'}

  

  test "all articles should have a unique token" do
    1000.times do |i|
      Ambassador.create(base_ambas_params)
    end

    assert (Ambassador.pluck(:token).count == Ambassador.pluck(:token).uniq.count), "Token count wasn't the same as Unique Token count"
  end
end
