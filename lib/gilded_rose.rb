require 'item'

class GildedRose

  MAX_ITEM_QUALITY = 50
  MIN_ITEM_QUALITY = 0
  NORMAL_ITEM_DECAY = 1
  BSPASS_TEN_DAY_THRESHOLD = 11
  BSPASS_FIVE_DAY_THRESHOLD = 6

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name.include? "Conjured"
        item.quality -= 2
      end
      if !is_aged_brie?(item) and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > MIN_ITEM_QUALITY
          if item.name != "Sulfuras, Hand of Ragnaros" && (!item.name.include? "Conjured")
            item.quality -= NORMAL_ITEM_DECAY
          end
        end
      else
        if item.quality < MAX_ITEM_QUALITY
          item.quality += 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < BSPASS_TEN_DAY_THRESHOLD && item.sell_in < 50
                item.quality += 1
            end
            if item.sell_in < 6
              if item.quality < MAX_ITEM_QUALITY
                item.quality += 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= NORMAL_ITEM_DECAY
      end
      if item.sell_in < MIN_ITEM_QUALITY
        if item.name.include? "Conjured"
          item.quality -= 2
        end
        if !is_aged_brie?(item)
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > MIN_ITEM_QUALITY
              if item.name != "Sulfuras, Hand of Ragnaros" && (!item.name.include? "Conjured")
                item.quality -= NORMAL_ITEM_DECAY
              end
            end
          else
            item.quality -= item.quality
          end
        else
          if item.quality < MAX_ITEM_QUALITY
            item.quality += 1
          end
        end
      end
    end
  end

  def is_aged_brie?(item)
    item.name == "Aged Brie"
  end
end
