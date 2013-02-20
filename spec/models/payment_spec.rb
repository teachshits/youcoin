#encoding: utf-8

require 'spec_helper'

describe Payment do

    before (:each) do
	@user = FactoryGirl.create(:user)
	User.current_user = @user
	
	@cash = Cash.create!( :name => "Test Cash", :balance => 100 )
	
	@category = Category.find_by_name('Общественный транспорт')
	
	@attr = { :summa => 20.23, :cash => @cash, :category => @category }
    end
    
    it 'should create a new payment' do
	Payment.create!(@attr)
    end
    
    it "should require a balance" do
	no_valid = Payment.new(@attr.merge(:summa => ""))
        no_valid.should_not be_valid
    end

    it "should require a category" do
	no_valid = Payment.new(@attr.merge(:category => nil))
        no_valid.should_not be_valid
    end
    
    it "should require a cash" do
	no_valid = Payment.new(@attr.merge(:cash => nil))
        no_valid.should_not be_valid
    end
    
    
    it 'change cash balance after add payment'  do
	@cash.balance = 100.00
	payment = Payment.new(@attr.merge(:cash => @cash))
	@cash.payments << payment
	@cash.save
	@cash.balance.should == (100 - payment.summa)
    end
    
    it 'should not change balance after update payment not change summa' do
	@cash.balance = 100.00

	payment = Payment.new(@attr.merge(:cash => @cash))
	@cash.payments << payment
	@cash.save
	@cash.reload
	balance = @cash.balance

	payment = @cash.payments.first
	payment.category = Category.find_by_name('Личные расходы')
	payment.save
	@cash.reload
	@cash.balance.should == balance
    end
    
    it 'should change balance after change payment summa' do
	balance = 100.00
	@cash.balance = balance
	payment = Payment.new(@attr.merge(:cash => @cash))
	@cash.payments << payment
	@cash.save
	delta = 10.03
	payment.summa = payment.summa - delta;
	payment.save
	@cash.reload
	
	@cash.balance.should == balance - (@attr[:summa] - delta)
    end
    
    it 'should change balance for come = true' do
	balance = 100.00
	payment = Payment.new
	payment.category = Category.find_by_name('Зарплата')
	payment.category.should_not == nil
	payment.category.come.should == true
	payment.summa = 87.56
	@cash.payments << payment
	payment.save
	@cash.reload
	
	@cash.balance.should == balance + payment.summa
	
    end

end