require "test_helper"

class ToysControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @toy = toys(:figure)
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect new when not logged in" do
    get new_toy_path
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Toy.count' do
      post toys_path, params: { micropost: { name: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_toy_path(@toy)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch toy_path(@toy), params: { toy: { name: @toy.name,
                                           description: @toy.description } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_toy_path(@toy)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch toy_path(@toy), params: { toy: { name: @toy.name,
                                           description: @toy.description } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Toy.count' do
      delete toy_path(@toy)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'Toy.count' do
      delete toy_path(@toy)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end
