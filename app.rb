require("sinatra")
require("sinatra/reloader")
require("./lib/stylist")
require("./lib/client")
require("./lib/appointment")
require("pg")
also_reload("lib/**/*.rb")

DB = PG.connect({dbname: 'hair_salon', user: 'postgres', password: 'secret'})

get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all
  erb(:stylists)
end

get('/stylists/new') do
  erb(:new_stylist)
end

post('/stylists/new') do
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  Stylist.new({first_name: first_name, last_name: last_name}).save
  @success_message = "#{first_name} #{last_name} has been added."
  erb(:new_stylist)
end
