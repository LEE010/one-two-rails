require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get stores_url
    assert_response :success
  end

  test "should get new" do
    get new_store_url
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post stores_url, params: { store: { account_number: @store.account_number, address2: @store.address2, address: @store.address, name: @store.name, phone_number: @store.phone_number, postcode: @store.postcode, regist_number: @store.regist_number, user_id: @store.user_id } }
    end

    assert_redirected_to store_url(Store.last)
  end

  test "should show store" do
    get store_url(@store)
    assert_response :success
  end

  test "should get edit" do
    get edit_store_url(@store)
    assert_response :success
  end

  test "should update store" do
    patch store_url(@store), params: { store: { account_number: @store.account_number, address2: @store.address2, address: @store.address, name: @store.name, phone_number: @store.phone_number, postcode: @store.postcode, regist_number: @store.regist_number, user_id: @store.user_id } }
    assert_redirected_to store_url(@store)
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete store_url(@store)
    end

    assert_redirected_to stores_url
  end
end
