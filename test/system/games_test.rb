require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Fill with a random word, and get a 'not in the grid'" do
    visit new_url
    fill_in "guess", with: "DSQD"
    click_on "Submit"
    assert_text "[0, not in the grid]"
  end

end
