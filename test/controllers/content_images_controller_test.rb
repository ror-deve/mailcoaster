require "test_helper"

class ContentImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @content_image = content_images(:one)
  end

  test "should get index" do
    get content_images_url
    assert_response :success
  end

  test "should get new" do
    get new_content_image_url
    assert_response :success
  end

  test "should create content_image" do
    assert_difference("ContentImage.count") do
      post content_images_url, params: { content_image: { account_id: @content_image.account_id, folder_id: @content_image.folder_id, image: @content_image.image } }
    end

    assert_redirected_to content_image_url(ContentImage.last)
  end

  test "should show content_image" do
    get content_image_url(@content_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_content_image_url(@content_image)
    assert_response :success
  end

  test "should update content_image" do
    patch content_image_url(@content_image), params: { content_image: { account_id: @content_image.account_id, folder_id: @content_image.folder_id, image: @content_image.image } }
    assert_redirected_to content_image_url(@content_image)
  end

  test "should destroy content_image" do
    assert_difference("ContentImage.count", -1) do
      delete content_image_url(@content_image)
    end

    assert_redirected_to content_images_url
  end
end
