require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("/", {type: :feature}) do
  it("loads homepage with content") do
    visit('/')
    expect(page).to have_content("SALONNOW")
  end

  it("displays the stylist page") do
    visit("/")
    click_link("Our Stylists")
    expect(page).to have_content("Our Stylists")
  end
end
