require("sinatra")
require("sinatra/reloader")
require("./lib/stylist")
require("./lib/client")
require("./lib/appointment")
also_reload("lib/**/*.rb")

get('/') do
  erb(:index)
end
