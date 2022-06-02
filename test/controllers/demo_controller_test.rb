require "test_helper"

class DemoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get demo_index_url
    assert_response :success
  end

  test "should get public_api" do
    get demo_public_api_url
    assert_response :success
  end

  test "should get candlesticks" do
    get demo_candlesticks_url
    assert_response :success
  end
end
