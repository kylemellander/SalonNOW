class Stylist
  attr_reader(:id, :first_name, :last_name, :full_name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i
    @first_name = attributes.fetch(:first_name).downcase.capitalize
    @last_name = attributes.fetch(:last_name).downcase.capitalize
    @full_name = "#{@first_name} #{@last_name}"
  end

  define_singleton_method(:all) do
    stylists = []
    stored_stylists = DB.exec("SELECT * FROM stylists ORDER BY last_name, first_name;")
    stored_stylists.each() do |stylist|
      id = stylist.fetch("id").to_i
      first_name = stylist.fetch("first_name")
      last_name = stylist.fetch("last_name")
      stylists.push(Stylist.new({id: id, first_name: first_name, last_name: last_name}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (first_name, last_name) VALUES ('#{first_name}', '#{last_name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists * WHERE id = #{id}")
    DB.exec("DELETE FROM appointments * WHERE stylist_id = #{id}")
    DB.exec("DELETE FROM clients * WHERE stylist_id = #{id}")
  end

  define_singleton_method(:find) do |id|
    Stylist.all.each do |stylist|
      return stylist if stylist.id == id
    end
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name, @first_name).downcase.capitalize
    @last_name = attributes.fetch(:last_name, @last_name).downcase.capitalize
    @full_name = "#{first_name} #{last_name}"
    DB.exec("UPDATE stylists SET first_name = '#{first_name}', last_name = '#{last_name}' WHERE id = #{id};")
  end

  define_method(:save_appointment) do |attributes|
    Appointment.new({stylist_id: id, client_id: attributes.fetch(:client_id).to_i, time: attributes.fetch(:time)}).save
  end

  define_method(:clients) do
    clients = []
    stored_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{id}")
    stored_clients.each do |client|
      id = client.fetch("id").to_i
      stylist_id = client.fetch("stylist_id").to_i
      first_name = client.fetch("first_name")
      last_name = client.fetch("last_name")
      phone = client.fetch("phone")
      clients.push(Client.new({id: id, stylist_id: stylist_id, first_name: first_name, last_name: last_name, phone: phone}))
    end
    clients
  end

  define_method(:appointments) do
    appointments = []
    stored_appointments = DB.exec("SELECT * FROM appointments WHERE stylist_id = #{id}")
    stored_appointments.each do |appointment|
      id = appointment.fetch("id").to_i
      stylist_id = appointment.fetch("stylist_id").to_i
      client_id = appointment.fetch("client_id").to_i
      time = appointment.fetch("time")
      appointments.push(Appointment.new({id: id, stylist_id: stylist_id, client_id: client_id, time: time}))
    end
    appointments
  end

  define_method(:==) do |other|
    id == other.id && first_name == other.first_name && last_name == other.last_name
  end

end
