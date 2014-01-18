require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get add_end_time" do
    get :add_end_time
    assert_response :success
  end

end
