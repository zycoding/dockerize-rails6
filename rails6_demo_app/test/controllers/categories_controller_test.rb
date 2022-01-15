require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get blog" do
    get categories_blog_url
    assert_response :success
  end
end
