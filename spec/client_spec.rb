require('spec_helper')

describe(Client) do
  describe(".all") do
    it("returns empty array when empty") do
      expect(Client.all).to(eq([]))
    end
  end
end
