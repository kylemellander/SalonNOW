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
end
