class Client
  attr_reader(:id, :stylist_id, :first_name, :last_name, :full_name, :phone)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i
    @stylist_id = attributes.fetch(:stylist_id).to_i
    @first_name = attributes.fetch(:first_name).downcase.capitalize
    @last_name = attributes.fetch(:last_name).downcase.capitalize
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

  define_method(:delete) do
    DB.exec("DELETE FROM clients * WHERE id = #{id};")
  end

  define_singleton_method(:find) do |id|
    Client.all.each do |client|
      return client if client.id == id
    end
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name, @first_name).downcase.capitalize
    @last_name = attributes.fetch(:last_name, @last_name).downcase.capitalize
    @full_name = "#{first_name} #{last_name}"
    @phone = attributes.fetch(:phone, @phone)
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
    DB.exec("UPDATE clients SET first_name = '#{first_name}', last_name = '#{last_name}', phone = '#{phone}', stylist_id = #{stylist_id} WHERE id = #{id};")
  end

  define_method(:stylist) do
    stored_stylists = DB.exec("SELECT * FROM stylists WHERE id = #{stylist_id}")
    stored_stylists.each do |stylist|
      id = stylist.fetch("id").to_i
      first_name = stylist.fetch("first_name")
      last_name = stylist.fetch("last_name")
      return Stylist.new({id: id, first_name: first_name, last_name: last_name})
    end
  end

  define_method(:==) do |other|
    id == other.id && stylist_id == other.stylist_id && first_name == other.first_name && last_name == other.last_name && phone == other.phone
  end
end
