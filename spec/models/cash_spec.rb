require 'spec_helper'

describe Cash do
    before(:each) do
	@user = FactoryGirl.create(:user)
	User.current_user = @user
	@attr = { :name => "Test Cash", :balance => 100 }
    end
    
    it "should create a new cash" do
	Cash.create!(@attr)
    end
    
    it "should require a name" do
	no_name_cash = Cash.new(@attr.merge(:name => ""))
        no_name_cash.should_not be_valid
    end

end