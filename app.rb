require("sinatra")
require("sinatra/reloader")
require("./lib/stylist")
require("./lib/client")
require("pg")
require("./lib/appointment")
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

get('/stylists/:id/edit') do
  id = params.fetch("id").to_i
  @stylist = Stylist.find(id)
  erb(:edit_stylist)
end

patch('/stylists/:id') do
  id = params.fetch("id").to_i
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  stylist = Stylist.find(id)
  old_full_name = stylist.full_name
  stylist.update({first_name: first_name, last_name: last_name})
  @success_message = "#{old_full_name} has been changed to #{stylist.full_name}."
  @stylists = Stylist.all
  erb(:stylists)
end

get('/stylists/:id') do
  id = params.fetch("id").to_i
  @stylist = Stylist.find(id)
  erb(:stylist)
end

delete('/stylists/:id') do
  id = params.fetch("id").to_i
  stylist = Stylist.find(id)
  @success_message = "#{stylist.full_name} has been deleted."
  stylist.delete
  @stylists = Stylist.all
  erb(:stylists)
end

get('/clients') do
  @clients = Client.all
  erb(:clients)
end

get('/clients/:id/edit') do
  id = params.fetch("id").to_i
  @client = Client.find(id)
  @stylists = Stylist.all
  erb(:edit_client)
end

patch('/clients/:id') do
  id = params.fetch("id").to_i
  first_name = params.fetch("first_name")
  last_name = params.fetch("last_name")
  phone = params.fetch("phone")
  stylist_id = params.fetch("stylist_id").to_i
  client = Client.find(id)
  old_full_name = client.full_name
  client.update({first_name: first_name, last_name: last_name, stylist_id: stylist_id, phone: phone})
  @success_message = "#{old_full_name} has been changed."
  @clients = Client.all
  erb(:clients)
end

delete('/clients/:id') do
  id = params.fetch("id").to_i
  client = Client.find(id)
  @success_message = "#{client.full_name} has been deleted."
  client.delete
  @clients = Client.all
  erb(:clients)
end

get('/clients/new') do
  @stylists = Stylist.all
  erb(:new_client)
end

post('/clients/new') do
  stylist_id = params.fetch("stylist_id").to_i
  if stylist_id == 0
    @error_message = "You must select a stylist"
    @first_name = params.fetch("first_name")
    @last_name = params.fetch("last_name")
    @phone = params.fetch("phone")
    @stylists = Stylist.all
    erb(:new_client)
  else
    first_name = params.fetch("first_name")
    last_name = params.fetch("last_name")
    phone = params.fetch("phone")
    ref = params.fetch("ref", nil)
    Client.new({stylist_id: stylist_id, first_name: first_name, last_name: last_name, phone: phone}).save
    @success_message = "#{first_name} #{last_name} has been added."
    if ref == "stylist"
      @stylist = Stylist.find(stylist_id)
      erb(:stylist)
    elsif ref == "add_client"
      @stylists = Stylist.all
      erb(:new_client)
    else
      erb(:index)
    end
  end
end

get('/appointments') do
  @appointments = Appointment.all
  erb(:appointments)
end

get('/appointments/new') do
  @stylists = Stylist.all
  @clients = Client.all
  erb(:new_appointment)
end

post('/appointments/new') do
  stylist_id = params.fetch("stylist_id").to_i
  client_id = params.fetch("client_id").to_i
  time = "#{params.fetch("date")} #{params.fetch("time")}"
  Appointment.new({stylist_id: stylist_id, client_id: client_id, time: time}).save
  @success_message = "An appointment has been schedule for #{time}."
  @stylists = Stylist.all
  @clients = Client.all
  erb(:new_appointment)
end

delete('/appointments/:id') do
  id = params.fetch("id").to_i
  Appointment.find(id).delete
  @success_message = "The Appointment has been deleted."
  @appointments = Appointment.all
  erb(:appointments)
end
