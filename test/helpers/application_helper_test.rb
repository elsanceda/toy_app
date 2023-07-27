require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "Toy App", full_title
    assert_equal "About | Toy App", full_title("About")
  end
end