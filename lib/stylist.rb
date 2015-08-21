class Stylist
  attr_reader(:id, :first_name, :last_name, :full_name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id, nil).to_i
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
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

  define_method(:==) do |other|
    id == other.id && first_name == other.first_name && last_name == other.last_name
  end

end
