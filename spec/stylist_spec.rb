require('spec_helper')

describe(Stylist) do
  before do
    @stylist1 = Stylist.new({first_name: "Courtney", last_name: "Phillips"})
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
end
