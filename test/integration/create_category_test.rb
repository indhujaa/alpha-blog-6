require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "Check Can Create and show category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count",2 do
      post categories_url ,params: {category: {name:"Sports"}}
      assert_response :redirect
      post categories_url ,params: {category: {name:"Travel"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Travel" ,response.body
  end

  test "Check Can Create and check invalid category" do
    get "/categories/new"
    assert_response :success
    # post categories_url ,params: {category: {name:"Sports"}}
    assert_no_difference "Category.count" do
      post categories_url ,params: {category: {name:""}}
      # post categories_url ,params: {category: {name:"Sports"}}
    end
    assert_match "Error" ,response.body
    assert_select "div.alert"
  end
end
