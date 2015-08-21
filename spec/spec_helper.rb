require('rspec')
require('client')
require('stylist')
require('pg')
require('pry')
require('appointment')

DB = PG.connect({:dbname => 'hair_salon_test', :user => 'postgres', :password => 'secret'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM clients *;")
    DB.exec("DELETE FROM stylists *;")
    DB.exec("DELETE FROM appointments *;")
  end
end
