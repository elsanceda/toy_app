require "test_helper"

class UsersProfile < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
end

class UsersProfileTest < UsersProfile
  include ApplicationHelper

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.toys.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.toys.paginate(page: 1).each do |toy|
      assert_match toy.name, response.body
    end
    assert_select 'a[href=?]', new_toy_path, text: '+ New', count: 0
  end
end

class NewToyButton < UsersProfile

  def setup
    super
    @other = users(:archer)
    log_in_as(@user)
  end
end

class NewToyButtonTest < NewToyButton

  test "should have new button for current user" do
    get user_path(@user)
    assert_select 'a[href=?]', new_toy_path, text: '+ New'
  end

  test "should not have new button for other users" do
    get user_path(@other)
    assert_select 'a[href=?]', new_toy_path, text: '+ New', count: 0
  end
end