require "test_helper"

class Admin::MakingStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_making_status_update_url
    assert_response :success
  end
end
