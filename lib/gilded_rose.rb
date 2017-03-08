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
      if contains_conjured?(item)
        item.quality -= 2
      end
      if !is_aged_brie?(item) and !is_backstage_pass?(item)
        if item.quality > MIN_ITEM_QUALITY
          if !is_sulfuras?(item) && !contains_conjured?(item)
            item.quality -= NORMAL_ITEM_DECAY
          end
        end
      else
        if item.quality < MAX_ITEM_QUALITY
          item.quality += 1
          if is_backstage_pass?(item)
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
      if !is_sulfuras?(item)
        item.sell_in -= NORMAL_ITEM_DECAY
      end
      if item.sell_in < MIN_ITEM_QUALITY
        if contains_conjured?(item)
          item.quality -= 2
        end
        if !is_aged_brie?(item)
          if !is_backstage_pass?(item)
            if item.quality > MIN_ITEM_QUALITY
              if !is_sulfuras?(item) && !contains_conjured?(item)
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

  def is_backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def is_sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def contains_conjured?(item)
    item.name.include? "Conjured"
  end
end
