require('spec_helper')

describe(Stylist) do
  before do
    @stylist1 = Stylist.new({first_name: "Courtney", last_name: "Phillips"})
    # @client1 = Client.new({first_name: "Andrew", last_name: "Dang", stylist_id: 1, phone: "503-555-5555"})
  end

  describe(".all") do
    it("returns empty array when empty") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves an entry to database") do
      @stylist1.save
      expect(Stylist.all()).to(eq([@stylist1]))
    end
  end

  describe("#delete") do
    it("deletes a stylist from the database") do
      @stylist1.save
      @stylist1.delete
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("finds a stylist by id") do
      @stylist1.save
      expect(Stylist.find(@stylist1.id)).to(eq(@stylist1))
    end
  end

  describe("#update") do
    it("updates the data of fields of a stylist") do
      @stylist1.save
      @stylist1.update({first_name: "Kyle", last_name: "Mellander"})
      expect(@stylist1.full_name).to(eq("Kyle Mellander"))
    end

    # it("creates appoints for stylists and clients") do
    #   @stylist1.save
    # end
  end
end
