require "application_system_test_case"

class SpeedTestsTest < ApplicationSystemTestCase
  setup do
    @speed_test = speed_tests(:one)
  end

  test "visiting the index" do
    visit speed_tests_url
    assert_selector "h1", text: "Speed Tests"
  end

  test "creating a Speed test" do
    visit speed_tests_url
    click_on "New Speed Test"

    fill_in "Download", with: @speed_test.download
    fill_in "Ping", with: @speed_test.ping
    fill_in "Server", with: @speed_test.server
    fill_in "Upload", with: @speed_test.upload
    click_on "Create Speed test"

    assert_text "Speed test was successfully created"
    click_on "Back"
  end

  test "updating a Speed test" do
    visit speed_tests_url
    click_on "Edit", match: :first

    fill_in "Download", with: @speed_test.download
    fill_in "Ping", with: @speed_test.ping
    fill_in "Server", with: @speed_test.server
    fill_in "Upload", with: @speed_test.upload
    click_on "Update Speed test"

    assert_text "Speed test was successfully updated"
    click_on "Back"
  end

  test "destroying a Speed test" do
    visit speed_tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Speed test was successfully destroyed"
  end
end
