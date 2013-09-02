require 'test_helper'

class TraveloguesControllerTest < ActionController::TestCase
  setup do
    @travelogue = travelogues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travelogues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travelogue" do
    assert_difference('Travelogue.count') do
      post :create, travelogue: { address: @travelogue.address, gmaps: @travelogue.gmaps, latitude: @travelogue.latitude, longitude: @travelogue.longitude }
    end

    assert_redirected_to travelogue_path(assigns(:travelogue))
  end

  test "should show travelogue" do
    get :show, id: @travelogue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travelogue
    assert_response :success
  end

  test "should update travelogue" do
    put :update, id: @travelogue, travelogue: { address: @travelogue.address, gmaps: @travelogue.gmaps, latitude: @travelogue.latitude, longitude: @travelogue.longitude }
    assert_redirected_to travelogue_path(assigns(:travelogue))
  end

  test "should destroy travelogue" do
    assert_difference('Travelogue.count', -1) do
      delete :destroy, id: @travelogue
    end

    assert_redirected_to travelogues_path
  end
end
