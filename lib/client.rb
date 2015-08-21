class Client
  attr_reader(:id, :stylist_id, :first_name, :last_name, :full_name, :phone)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i
    @stylist_id = attributes.fetch(:stylist_id).to_i
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @phone = attributes.fetch(:phone)
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

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (first_name, last_name, phone, stylist_id) VALUES ('#{first_name}', '#{last_name}', '#{phone}', #{stylist_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  define_method(:==) do |other|
    id == other.id && stylist_id == other.stylist_id && first_name == other.first_name && last_name == other.last_name && phone == other.phone
  end
end
