class Client
  attr_reader(:id, :stylist_id, :first_name, :last_name, :full_name, :phone)

  define_method(:initialize) do |attributes|
    @id = params.fetch(:id, nil).to_i
    @stylist_id = params.fetch(:stylist_id).to_i
    @first_name = params.fetch(:first_name)
    @last_name = params.fetch(:last_name)
    @phone = params.fetch(:phone)
    @full_name = "#{first_name} #{last_name}"
  end

  define_singleton_method(:all) do
    clients = []
    stored_clients = DB.exec("SELECT * FROM clients ORDER BY last_name, first_name;")
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
end
