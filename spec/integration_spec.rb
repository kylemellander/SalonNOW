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
end

describe("/stylists", {type: :feature}) do
  it("displays the stylist page") do
    visit("/")
    click_link("Our Stylists")
    expect(page).to have_content("Our Stylists")
  end

  it("successfully adds a stylist") do
    visit('/')
    click_link("Add a Stylist")
    fill_in("first_name", with: "Kyle")
    fill_in("last_name", with: "Mellander")
    click_button("Add Stylist")
    expect(page).to have_content("Kyle Mellander has been added.")
  end

  it("successfully edits a stylist") do
    stylist1 = Stylist.new({first_name: "Kyle", last_name: "Mellander"})
    stylist1.save
    visit('/stylists')
    click_link("edit")
    fill_in("first_name", with: "Edward")
    fill_in("last_name", with: "Scissorhands")
    click_button("Submit Changes")
    expect(page).to have_content("Kyle Mellander has been changed to Edward Scissorhands.")
  end

  it("displays all clients for stylist") do
    stylist1 = Stylist.new({first_name: "Kyle", last_name: "Mellander"})
    client1 = Client.new({first_name: "Harry", last_name: "Henderson", phone: "503-555-5555", stylist_id: 1})
    stylist1.save
    client1.save
    client1.update({stylist_id: stylist1.id})
    visit('/stylists')
    click_link("See Kyle's clients")
    expect(page).to have_content("Harry Henderson")
  end

  it("deletes a stylist") do
    stylist1 = Stylist.new({first_name: "Kyle", last_name: "Mellander"})
    stylist1.save
    visit('/stylists')
    click_button('btn-delete')
    expect(page).to have_content('Kyle Mellander has been deleted.')
  end
end

describe("/clients", {type: :feature}) do
  it("displays the clients page") do
    visit("/")
    click_link("Our Clients")
    expect(page).to have_content("Our Clients")
  end

  it("successfully edits a client") do
    stylist1 = Stylist.new({first_name: "Kyle", last_name: "Mellander"})
    stylist1.save
    client1 = Client.new({first_name: "Harry", last_name: "Henderson", phone: "503-555-5555", stylist_id: stylist1.id})
    client1.save
    visit("/clients")
    click_link("edit")
    fill_in("first_name", with: "Edward")
    fill_in("last_name", with: "Scissorhands")
    click_button("Submit Changes")
    expect(page).to have_content("Harry Henderson has been changed.")
  end
end
