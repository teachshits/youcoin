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
		get 'add_transfer', :id=>cash_a, :transfer_cash_id=>cash_b, :summa=>12.54, :format=>'js'
	    end
	end
	
	describe "Add Payment" do
	    before(:each) do
		@attr = { :name => "Cash A", :balance => 1457.69}
	    end
	    
	    it "should by successful" do
		cash = Cash.create!(@attr)
		category = Category.find_by_name("Зарплата")
		get 'add_payment', :id=>cash, :category_id=>category.id, :summa=>12.54, :format=>'js'
	    end
	end
	
	describe "Change Balance" do
	    before(:each) do
		@attr = { :name => "Cash A", :balance => 1457.69}
	    end
	    
	    it "should by successful" do
		cash = Cash.create!(@attr)
		category = Category.find_by_name("Зарплата")
		get 'change_balance', :id=>cash, :new_balance=>12.54, :format=>'js'
	    end
	end

end