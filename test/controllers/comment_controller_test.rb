require 'test_helper'

class CommentControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get comment_create_url
    assert_response :success
  end

  test "should get destroy" do
    get comment_destroy_url
    assert_response :success
  end

  test "should get update" do
    get comment_update_url
    assert_response :success
  end

  test "should get index" do
    get comment_index_url
    assert_response :success
  end

  test "should get form" do
    get comment_form_url
    assert_response :success
  end

end
