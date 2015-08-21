require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("/", {type: :feature}) do
  it("loads homepage with content") do
    visit('/')
    expect(page).to have_content("SALON")
  end
end
