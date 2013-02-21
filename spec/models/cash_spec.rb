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
    
    describe Transfer do
	
	before(:each) do
	    @attr_cash_a = { :name => "Cash A", :balance => 1457.69}
	    @attr_cash_b = { :name => "Cash B", :balance => 254.27 }
	end
	
	it "should be create_transfer" do
	    cash_a = Cash.create!(@attr_cash_a)
	    cash_b = Cash.create!(@attr_cash_b)
	    transfer = 12.87
	    cash_a.create_transfer(cash_b, transfer)
	    cash_a.balance.should == @attr_cash_a[:balance] - transfer
	    cash_b.balance.should == @attr_cash_b[:balance] + transfer
	end
    end
    
    describe 'Balance' do

	before(:each) do
	    @attr = { :name => "Cash ", :balance => 1457.69}
	end
	
	it "should change balance" do
	    cash = Cash.create!(@attr)
	    cash.change_balance(400)
	    cash.balance.should == 400
	    cash.payments.first.summa.should == (1457.69-400)
	end
	
    end

end