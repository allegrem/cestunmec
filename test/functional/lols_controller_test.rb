require 'test_helper'

class LolsControllerTest < ActionController::TestCase
  setup do
    @lol = lols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lol" do
    assert_difference('Lol.count') do
      post :create, :lol => @lol.attributes
    end

    assert_redirected_to lol_path(assigns(:lol))
  end

  test "should show lol" do
    get :show, :id => @lol
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lol
    assert_response :success
  end

  test "should update lol" do
    put :update, :id => @lol, :lol => @lol.attributes
    assert_redirected_to lol_path(assigns(:lol))
  end

  test "should destroy lol" do
    assert_difference('Lol.count', -1) do
      delete :destroy, :id => @lol
    end

    assert_redirected_to lols_path
  end
end
