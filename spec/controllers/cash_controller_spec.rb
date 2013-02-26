#encoding: utf-8
require 'spec_helper'

describe CashesController do
    include Devise::TestHelpers
    render_views

	before(:each) do
	    @user = FactoryGirl.create(:user)
	    User.current_user = @user
	    sign_in @user
	end

	describe "GET 'new'" do
	    it "should be successful" do
		get 'new'
		response.should be_success
	    end

	    it "should have the right title" do
		get 'new'
#		response.should have_selector("title", :content => "Cash")
	    end
	end
	
	describe "Add Transfer" do
	    before(:each) do
		@attr_cash_a = { :name => "Cash A", :balance => 1457.69}
	        @attr_cash_b = { :name => "Cash B", :balance => 254.27 }
	    end
	
	    it "should by successful" do
		cash_a = Cash.create!(@attr_cash_a)
		cash_b = Cash.create!(@attr_cash_b)
		post 'add_transfer', :id=>cash_a, :transfer_cash_id=>cash_b, :summa=>12.54, :format=>'js', :come=>true
		response.should be_success
	    end
	    
	    it "should by transfer into cash" do
		cash_a = Cash.create!(@attr_cash_a)
		cash_b = Cash.create!(@attr_cash_b)
		post 'add_transfer', :id=>cash_a, :transfer_cash_id=>cash_b, :summa=>14.21, :format=>'js', :come=>false
		cash_b.reload
		cash_a.reload
		cash_b.balance.should == (@attr_cash_b[:balance] + 14.21)
		cash_a.balance.should == (@attr_cash_a[:balance] - 14.21)
	    end
	
	    it "should by transfer from cash" do
		cash_a = Cash.create!(@attr_cash_a)
		cash_b = Cash.create!(@attr_cash_b)
		post 'add_transfer', :id=>cash_a, :transfer_cash_id=>cash_b, :summa=>14.21, :format=>'js', :come=>true
		cash_b.reload
		cash_a.reload
		cash_b.balance.should == (@attr_cash_b[:balance] - 14.21)
		cash_a.balance.should == (@attr_cash_a[:balance] + 14.21)
	    end
	
	end
	
	describe "Add Payment" do
	    before(:each) do
		@attr = { :name => "Cash A", :balance => 1457.69}
	    end
	    
	    it "should by successful" do
		cash = Cash.create!(@attr)
		category = Category.find_by_name("Зарплата")
		post 'add_payment', :id=>cash, :category_id=>category.id, :summa=>12.54, :format=>'js'
		response.should be_success
	    end
	end
	
	describe "Change Balance" do
	    before(:each) do
		@attr = { :name => "Cash A", :balance => 1457.69}
	    end
	    
	    it "should by successful" do
		cash = Cash.create!(@attr)
		category = Category.find_by_name("Зарплата")
		post 'change_balance', :id=>cash, :new_balance=>12.54, :format=>'js'
		response.should be_success
	    end
	end

end