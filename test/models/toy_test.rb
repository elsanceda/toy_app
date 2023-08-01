require "test_helper"

class ToyTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @toy = @user.toys.build(name: "Toy")
  end

  test "should be valid" do
    assert @toy.valid?
  end

  test "user id should be present" do
    @toy.user_id = nil
    assert_not @toy.valid?
  end

  test "name should be present" do
    @toy.name = " "
    assert_not @toy.valid?
  end

  test "order should be most recent first" do
    assert_equal toys(:most_recent), Toy.first
  end

  #test "image should be present" do
  #  assert @toy.image.attached?
  #  assert_not @toy.valid?
  #end
end
