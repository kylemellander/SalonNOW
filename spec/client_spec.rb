require('spec_helper')

describe(Client) do
  before do
    @client1 = Client.new({first_name: "Harry", last_name: "Henderson", phone: "503-555-5555", stylist_id: 1})
    @stylist1 = Stylist.new({first_name: "Courtney", last_name: "Phillips"})
  end

  describe(".all") do
    it("returns empty array when empty") do
      expect(Client.all).to(eq([]))
    end
  end

  describe("#save") do
    it("saves a new client") do
      @client1.save
      expect(Client.all).to(eq([@client1]))
    end
  end

  describe("#delete") do
    it("deletes a saved client from database") do
      @client1.save
      @client1.delete
      expect(Client.all).to(eq([]))
    end
  end

  describe(".find") do
    it("finds a client by id") do
      @client1.save
      expect(Client.find(@client1.id)).to(eq(@client1))
    end
  end

  describe("#stylist") do
    it("returns the stylist of a client") do
      @client1.save
      @stylist1.save
      @client1.update({stylist_id: @stylist1.id})
      expect(@client1.stylist).to(eq(@stylist1))
    end
  end

  describe("#update") do
    it("updates the data of a client") do
      @client1.save
      @client1.update({first_name: "Courtney", last_name: "Phillips", phone: "503", stylist_id: 2})
      expect(@client1.full_name).to(eq("Courtney Phillips"))
      expect(@client1.phone).to(eq("503"))
      expect(@client1.stylist_id).to(eq(2))
    end
  end
end
