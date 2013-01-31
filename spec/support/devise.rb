module DeviseControllerMacros # http://git.io/WHvARA
  extend ActiveSupport::Concern

  def login_admin(user = nil)
    user ||= FactoryGirl.create(:user, :admin)
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in user
  end

  def login_customer(user = nil)
    user ||= FactoryGirl.create(:user, :customer)
    @request.env["devise.mapping"] = Devise.mappings[:customer]
    sign_in user
  end

  module ClassMethods
    def login_admin(&block)
      before(:each) do
        login_admin block.try(:call)
      end
    end

    def login_customer(&block)
      before(:each) do
        login_customer block.try(:call)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include DeviseControllerMacros, :type => :controller
end
