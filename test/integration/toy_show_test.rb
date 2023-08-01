require "test_helper"

class ToyShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @toy  = toys(:figure)
  end

  test "should display toy" do
    get toy_path(@toy)
    assert_response :success
    assert_template 'toys/show'
  end
end
