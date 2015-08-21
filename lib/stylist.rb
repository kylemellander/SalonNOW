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
end
