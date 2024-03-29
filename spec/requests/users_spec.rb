require 'spec_helper'

describe "Users" do

include Devise::TestHelpers

    describe "signup" do
    
	describe "failure" do
	
	    it "should not make a new user" do
		lambda do 
		visit new_user_registration_path
		fill_in "Name",         :with => " "
		fill_in "Email",         :with => " "
		fill_in "Password",         :with => " "
		fill_in "Password Confirmation",         :with => " "
		click_button
		response.should render_template('users/new')
		response.should have_selector("div#error_explanation")
		end.should_not change(User, :count)
	    end
	    
	end
	
    end
    
end
