require('spec_helper')

describe(Appointment) do
  before do
    @stylist1 = Stylist.new({first_name: "Courtney", last_name: "Phillips"})
    @client1 = Client.new({first_name: "Andrew", last_name: "Dang", stylist_id: 1, phone: "503-555-5555"})
    @appointment1 = Appointment.new({stylist_id: 1, client_id: 1, time: "2015-09-01 09:00:00"})
  end

  describe(".all") do
    it("returns all appointments") do
      expect(Appointment.all).to(eq([]))
    end
  end

  describe("#save") do
    it("saves an appointment") do
      @appointment1.save
      expect(Appointment.all).to eq [@appointment1]
    end
  end

  describe("#time") do
    it("returns the time of an appointment") do
      @appointment1.save
      expect(@appointment1.time).to eq "2015-09-01 09:00:00"
    end
  end
end
