require 'test_helper'

class VannesControllerTest < ActionController::TestCase
  setup do
    @vanne = vannes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vannes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vanne" do
    assert_difference('Vanne.count') do
      post :create, :vanne => @vanne.attributes
    end

    assert_redirected_to vanne_path(assigns(:vanne))
  end

  test "should show vanne" do
    get :show, :id => @vanne
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vanne
    assert_response :success
  end

  test "should update vanne" do
    put :update, :id => @vanne, :vanne => @vanne.attributes
    assert_redirected_to vanne_path(assigns(:vanne))
  end

  test "should destroy vanne" do
    assert_difference('Vanne.count', -1) do
      delete :destroy, :id => @vanne
    end

    assert_redirected_to vannes_path
  end
end
