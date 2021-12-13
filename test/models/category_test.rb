require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category=Category.new(name:"Sports")
  end
  test "Category is valid" do
    assert @category.valid?
  end
  test "name should present" do
    @category.name=""
    assert_not @category.valid?
  end
  test "name should be unquie" do
    @category.save
    @category2=Category.new(name:"Sports")
    assert_not @category2.valid?
  end
  test "Name should not be too long" do
    @category.name="a"*29
    assert_not @category.valid?
  end

  test "Name should not be too short" do
    @category.name="aa"
    assert_not @category.valid?
  end

end
