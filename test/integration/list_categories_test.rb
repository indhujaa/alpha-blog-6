require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  setup do
    @category1=Category.create(name:"Sports")
    @category2=Category.create(name:"Travel")
  end
  test "check category listing page" do
    get "/categories"
    assert_select "a[href=?]",category_path(@category1),text:@category1.name
    assert_select "a[href=?]",category_path(@category2),text:@category2.name
  end
end
