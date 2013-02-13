#encoding: utf-8
class CashesController < ApplicationController

  before_filter :authenticate_user!
  
  # GET /cashes
  # GET /cashes.json
  def index
    @cashes = Cash.find(:all, :conditions => ["user_id = ?", current_user])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cashes }
    end
  end

  # GET /cashes/1
  # GET /cashes/1.json
  def show
    collection_for_parent_select;
    
    @cash = Cash.find(params[:id])
    
    log = Rails.logger
    
    if (@cash && params[:summa]!= nil && params[:summa]!="" ) then
	payment = Payment.new;
	payment.summa = params[:summa];	    
    	payment.category_id = params[:category_id];
	@cash.payments << payment
	@cash.save
	@cash.reload
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @cash }
    end
  end

  # GET /cashes/new
  # GET /cashes/new.json
  def new
    @cash = Cash.new
    @cash.payments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cash }
    end
  end

  # GET /cashes/1/edit
  def edit
    @cash = Cash.find(params[:id])
  end

  # POST /cashes
  # POST /cashes.json
  def create
    @cash = Cash.new(params[:cash])
    @cash.user = current_user
    respond_to do |format|
      if @cash.save
        format.html { redirect_to @cash, notice: 'Cash was successfully created.' }
        format.json { render json: @cash, status: :created, location: @cash }
      else
        format.html { render action: "new" }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cashes/1
  # PUT /cashes/1.json
  def update
    @cash = Cash.find(params[:id])

    respond_to do |format|
      if @cash.update_attributes(params[:cash])
        format.html { redirect_to @cash, notice: 'Cash was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cashes/1
  # DELETE /cashes/1.json
  def destroy
    @cash = Cash.find(params[:id])
    @cash.destroy

    respond_to do |format|
      format.html { redirect_to cashes_url }
      format.json { head :no_content }
    end
  end

  def add_transfer
  
    ActiveRecord::Base.transaction do
    
  
    @cash = Cash.find(params[:id])
    
    come_ = true    if params[:come]=='true'
    come_ = false   if params[:come]=='false'
    
    transfer = Transfer.new(params[:transfer])
    
    transfer.cash = @cash
    transfer.summa = params[:summa]
    transfer.category = Category.where("name = ? and come = ?", 'Перевод', come_).first;
    transfer.transfer_cash_id = params[:transfer_cash_id]
    
    if (come_ == false) then
	transfer.summa = transfer.summa 
    end
    
    transfer.save!
    
    @cash.reload
    
end

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @cash }
    end
  end
  
  def balance_edit
  
    @cash = Cash.find(params[:id])
    
    balance_delta = @cash.balance - params[:balance_edit].to_f
    
    if (balance_delta != 0) then
    
#        if (balance_delta < 0) then    	    
#	end

    ActiveRecord::Base.transaction do    
        payment = Payment.new
        payment.cash = @cash
        payment.category = Category.find(:all, :conditions=>["name = ? and come = ?", 'Изменение остатка', (balance_delta < 0)]).first
        payment.summa = balance_delta
        
        payment.save
    end
    end
  
    respond_to do |format|
	format.js
    end
  end
  
before_filter :collection_for_parent_select, :except => [:show]

  def collection_for_parent_select
    @categories = ancestry_options(Category.arrange(:conditions => ["user_id = ?", current_user],:order => 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
  end

  def ancestry_options(items)
    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      #this is a recursive call:
      result += ancestry_options(sub_items) {|i| "#{'-' * i.depth} #{i.name}" }
    end
    result
  end

  
end
