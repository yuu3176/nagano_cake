require "test_helper"

class Admin::OrderDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_order_details_show_url
    assert_response :success
  end
end
