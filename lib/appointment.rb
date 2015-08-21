class Appointment
  attr_reader(:id, :stylist_id, :client_id, :time)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i
    @stylist_id = attributes.fetch(:stylist_id).to_i
    @client_id = attributes.fetch(:client_id).to_i
    @time = attributes.fetch(:time)
  end

  define_singleton_method(:all) do
    appointments = []
    returned_appointments = DB.exec("SELECT * FROM appointments ORDER BY time;")
    returned_appointments.each do |appointment|
      id = appointment.fetch("id").to_i
      stylist_id = appointment.fetch("stylist_id").to_i
      client_id = appointment.fetch("client_id").to_i
      time = appointment.fetch("time")
      appointments.push(Appointment.new({id: id, stylist_id: stylist_id, client_id: client_id, time: time}))
    end
    appointments
  end
end
