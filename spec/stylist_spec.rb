require('spec_helper')

describe(Stylist) do
  before do
    @stylist1 = Stylist.new({first_name: "Courtney", last_name: "Phillips"})
    @client1 = Client.new({first_name: "Andrew", last_name: "Dang", stylist_id: 1, phone: "503-555-5555"})
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

  describe("#clients") do
    it("finds all clients for a stylist") do
      @stylist1.save
      @client1.save
      @client1.update({stylist_id: @stylist1.id})
      expect(@stylist1.clients).to(eq([@client1]))
    end
  end

  describe("#update") do
    it("updates the data of fields of a stylist") do
      @stylist1.save
      @stylist1.update({first_name: "Kyle", last_name: "Mellander"})
      expect(@stylist1.full_name).to(eq("Kyle Mellander"))
    end

    it("creates appointments for stylists and clients") do
      @stylist1.save
      @client1.save
      @stylist1.save_appointment({client_id: @client1.id, time: "2015-09-01 09:00:00"})
      expect(@stylist1.appointments.first.time).to(eq("2015-09-01 09:00:00"))
    end
  end

  describe("#appointments") do
    it("returns an array of appointments that the stylist has") do
      @stylist1.save
      @client1.save
      appointment1 = Appointment.new({stylist_id: @stylist1.id, client_id: @client1.id, time: "2015-09-01 09:00:00"})
      appointment1.save
      expect(@stylist1.appointments).to eq [appointment1]
    end
  end
end
