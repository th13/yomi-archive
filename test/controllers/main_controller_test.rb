require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get vocab" do
    get :vocab
    assert_response :success
  end

  test "should get read" do
    get :read
    assert_response :success
  end

  test "should get analyze" do
    get :analyze
    assert_response :success
  end

end
