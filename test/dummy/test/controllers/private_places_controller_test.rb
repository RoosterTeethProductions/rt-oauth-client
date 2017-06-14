require 'test_helper'

class PrivatePlacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @private_place = private_places(:one)
  end

  test "should get index" do
    get private_places_url
    assert_response :success
  end

  test "should get new" do
    get new_private_place_url
    assert_response :success
  end

  test "should create private_place" do
    assert_difference('PrivatePlace.count') do
      post private_places_url, params: { private_place: {  } }
    end

    assert_redirected_to private_place_url(PrivatePlace.last)
  end

  test "should show private_place" do
    get private_place_url(@private_place)
    assert_response :success
  end

  test "should get edit" do
    get edit_private_place_url(@private_place)
    assert_response :success
  end

  test "should update private_place" do
    patch private_place_url(@private_place), params: { private_place: {  } }
    assert_redirected_to private_place_url(@private_place)
  end

  test "should destroy private_place" do
    assert_difference('PrivatePlace.count', -1) do
      delete private_place_url(@private_place)
    end

    assert_redirected_to private_places_url
  end
end
