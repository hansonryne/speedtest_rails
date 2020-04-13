require 'test_helper'

class SpeedTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @speed_test = speed_tests(:one)
  end

  test "should get index" do
    get speed_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_speed_test_url
    assert_response :success
  end

  test "should create speed_test" do
    assert_difference('SpeedTest.count') do
      post speed_tests_url, params: { speed_test: { download: @speed_test.download, ping: @speed_test.ping, server: @speed_test.server, upload: @speed_test.upload } }
    end

    assert_redirected_to speed_test_url(SpeedTest.last)
  end

  test "should show speed_test" do
    get speed_test_url(@speed_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_speed_test_url(@speed_test)
    assert_response :success
  end

  test "should update speed_test" do
    patch speed_test_url(@speed_test), params: { speed_test: { download: @speed_test.download, ping: @speed_test.ping, server: @speed_test.server, upload: @speed_test.upload } }
    assert_redirected_to speed_test_url(@speed_test)
  end

  test "should destroy speed_test" do
    assert_difference('SpeedTest.count', -1) do
      delete speed_test_url(@speed_test)
    end

    assert_redirected_to speed_tests_url
  end
end
