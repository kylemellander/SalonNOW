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
