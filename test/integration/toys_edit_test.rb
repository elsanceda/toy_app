require "test_helper"

class ToysEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @toy = toys(:figure)
    log_in_as(@user)
    get edit_toy_path(@toy)
  end

  test "unsuccessful edit" do
    assert_template 'toys/edit'
    patch toy_path(@toy), params: { toy: { name: "" } }
    assert_template 'toys/edit'
  end

  test "successful edit" do
    name = "New toy"
    description = "Recently bought toy"
    patch toy_path(@toy), params: { toy: { name: name,
                                           description: description } }
    assert_not flash.empty?
    assert_redirected_to @toy
    @toy.reload
    assert_equal name,  @toy.name
    assert_equal description, @toy.description
  end
end
