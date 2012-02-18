require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get presse" do
    get :presse
    assert_response :success
  end

  test "should get followus" do
    get :followus
    assert_response :success
  end

end
