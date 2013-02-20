require 'spec_helper'

describe CashController do
    render_views
    
    before(:each) do
	@user = Factory(:user)
    end
end