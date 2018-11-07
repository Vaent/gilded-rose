class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      break if item.name == "Sulfuras, Hand of Ragnaros"
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrement_quality(item)
      else
        increment_quality(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          increment_quality(item) if item.sell_in < 11
          increment_quality(item) if item.sell_in < 6
        end
      end
      item.sell_in -= 1
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            decrement_quality(item)
          else
            item.quality = 0
          end
        else
          increment_quality(item)
        end
      end
      limit_quality(item)
    end
  end

  def increment_quality(item)
    item.quality += 1
  end

  def decrement_quality(item)
    item.quality -= 1
  end

  def limit_quality(item)
    item.quality = item.quality.clamp(0,50)
  end
end
