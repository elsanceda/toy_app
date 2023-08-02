require "test_helper"

class ToysNotLoggedInTest < ActionDispatch::IntegrationTest
  
  def setup
    get root_path
  end

  test "should paginate toys" do
    assert_select 'div.pagination', count: 2
  end

  test "should display toys correctly" do
    first_page_of_users = Toy.paginate(page: 1)
    first_page_of_users.each do |toy|
      assert_match toy.name, response.body
    end
    assert_select 'a[href=?]', new_toy_path, text: '+ New', count: 0
  end
end

class ToysInterface < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
    get root_path
  end
end

class ToysInterfaceTest < ToysInterface

  test "should not have welcome message when logged-in" do
    assert_select 'div.welcome-box', count: 0
  end

  test "should have new toy button when logged-in" do
    assert_select 'a[href=?]', new_toy_path, text: '+ New', count: 1
  end

  test "should show errors but not create toy on invalid submission" do
    assert_no_difference 'Toy.count' do
      post toys_path, params: { toy: { name: "" } }
    end
    assert_select 'div#error_explanation'
  end

  test "should create a toy on valid submission" do
    name = "My new toy"
    description = "A toy I recently bought"
    assert_difference 'Toy.count', 1 do
      post toys_path, params: { toy: { name: name,
                                       description: description } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match name, response.body
  end

  test "should be able to delete own toy" do
    first_toy = @user.toys.paginate(page: 1).first

    assert_difference 'Toy.count', -1 do
      delete toy_path(first_toy)
    end
  end
end
