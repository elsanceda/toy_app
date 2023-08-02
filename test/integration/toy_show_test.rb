require "test_helper"

class ToyShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @toy  = toys(:figure)
    @user = users(:michael)
  end

  test "should display toy" do
    get toy_path(@toy)
    assert_response :success
    assert_template 'toys/show'
    assert_select 'a[href=?]', edit_toy_path, text: 'Edit', count: 0
    assert_select 'a[href=?]', toy_path, text: 'Delete', count: 0
  end

  test "should display edit and delete links for correct user" do
    log_in_as(@user)
    get toy_path(@toy)
    assert_select 'a[href=?]', edit_toy_path, text: 'Edit', count: 1
    assert_select 'a[href=?]', toy_path, text: 'Delete', count: 1
  end
end
