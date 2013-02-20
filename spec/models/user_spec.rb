require 'spec_helper'
describe User do
    before(:each) do
#	@attr = { :name => "Example User", :email => "user@example.com", :password => "test1test", :password_confirmation => "test1test" }
    end
    
    it "should create a new instance given valid attribute" do
	Factory.create(:user).should be_valid
    end
    
end