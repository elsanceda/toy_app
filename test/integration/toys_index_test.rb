require "test_helper"

class ToysIndexTest < ActionDispatch::IntegrationTest

  def setup
    get toys_path
  end

  test "should render the index page" do
    assert_template 'toys/index'
  end

  test "should paginate toys" do
    assert_select 'div.pagination', count: 2
  end

  test "should have toy links" do
    first_page_of_toys = Toy.paginate(page: 1)
    first_page_of_toys.each do |toy|
      assert_select 'a[href=?]', toy_path(toy), text: 'View'
    end
  end
end
