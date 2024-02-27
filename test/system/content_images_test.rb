require "application_system_test_case"

class ContentImagesTest < ApplicationSystemTestCase
  setup do
    @content_image = content_images(:one)
  end

  test "visiting the index" do
    visit content_images_url
    assert_selector "h1", text: "Content images"
  end

  test "should create content image" do
    visit content_images_url
    click_on "New content image"

    fill_in "Account", with: @content_image.account_id
    fill_in "Folder", with: @content_image.folder_id
    fill_in "Image", with: @content_image.image
    click_on "Create Content image"

    assert_text "Content image was successfully created"
    click_on "Back"
  end

  test "should update Content image" do
    visit content_image_url(@content_image)
    click_on "Edit this content image", match: :first

    fill_in "Account", with: @content_image.account_id
    fill_in "Folder", with: @content_image.folder_id
    fill_in "Image", with: @content_image.image
    click_on "Update Content image"

    assert_text "Content image was successfully updated"
    click_on "Back"
  end

  test "should destroy Content image" do
    visit content_image_url(@content_image)
    click_on "Destroy this content image", match: :first

    assert_text "Content image was successfully destroyed"
  end
end
