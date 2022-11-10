require "test_helper"

class Admin::StatusControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_status_update_url
    assert_response :success
  end
end
