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
    it 'item quality wont become a negative value' do
      items = [Item.new("Wallet", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    context 'Aged Brie' do
      it 'will increase quality as it gets older' do
        items = [Item.new("Aged Brie", 2, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
      it 'quality cant be more than 50' do
        items = [Item.new("Aged Brie", 50, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).not_to eq 51
      end
    end
      context 'Sulfuras' do
        it 'items will not decrease quality with age' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 50, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
        it 'sell_in date will not decrease' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 50, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end
    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'will increase quality as it gets older when sell_in > 10' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 1)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
      it 'will increase quality x2 when sell_in is < 11' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end
      it 'will increase quality x3 when sell_in is < 6' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 5
      end
      it 'quality will drop to 0 after sell_in date reaches 0' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end
    context 'Conjured' do
      it 'quality degrades twice as fast as normal' do
        items = [Item.new("Conjured", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 8
      end
      it 'quality degrades 4x as fast as normal once sell_in reaches 0' do
        items = [Item.new("Conjured", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 6
      end
    end
  end
end
