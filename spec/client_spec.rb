require('spec_helper')

describe(Client) do
  before do
    @client1 = Client.new({first_name: "Harry", last_name: "Henderson", phone: "503-555-5555", stylist_id: 1})
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
end
