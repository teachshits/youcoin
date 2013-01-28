#encoding: utf-8
class HomeController < ApplicationController

    def index
	if user_signed_in?
          redirect_to :controller=>'cashes', :action => 'index'
        end
    end
    
end
