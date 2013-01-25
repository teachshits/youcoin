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
    
    if (@cash && params[:summa] != nil) then
	payment = Payment.new;
	payment.summa = params[:summa];
	payment.category_id = params[:category_id];
	@cash.payments << payment
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

before_filter :collection_for_parent_select, :except => [:show]

  def collection_for_parent_select
    @categories = ancestry_options(Category.unscoped.arrange(:conditions => ["user_id = ?", current_user],:order => 'name')) {|i| "#{'-' * i.depth} #{i.name}" }
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
