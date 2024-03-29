require 'test_helper'

class CashesControllerTest < ActionController::TestCase
  setup do
    @cash = cashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cash" do
    assert_difference('Cash.count') do
      post :create, cash: { name: @cash.name }
    end

    assert_redirected_to cash_path(assigns(:cash))
  end

  test "should show cash" do
    get :show, id: @cash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cash
    assert_response :success
  end

  test "should update cash" do
    put :update, id: @cash, cash: { name: @cash.name }
    assert_redirected_to cash_path(assigns(:cash))
  end

  test "should destroy cash" do
    assert_difference('Cash.count', -1) do
      delete :destroy, id: @cash
    end

    assert_redirected_to cashes_path
  end
end
