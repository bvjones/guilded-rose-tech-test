require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    it 'item quality decreases over time' do
      items = [Item.new("Wallet", 10, 20)]
      GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 19
    end
    it 'item sell_in decreases over time' do
      items = [Item.new("Wallet", 10, 20)]
      GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 9
    end
  end

end
