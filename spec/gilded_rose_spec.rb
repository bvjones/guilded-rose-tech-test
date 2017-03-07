require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("Wallet", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "Wallet"
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
    it 'once sell by passed, it degrades quality twice as fast' do
      items = [Item.new("Wallet", 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 18
    end
  end

end