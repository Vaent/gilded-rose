class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            decrement_quality(item)
          end
        end
      else
        increment_quality(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
            increment_quality(item)
          end
          if item.sell_in < 6
            increment_quality(item)
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                decrement_quality(item)
              end
            end
          else
            item.quality = 0
          end
        else
          increment_quality(item)
        end
      end
      max_quality(item)
    end
  end

  def increment_quality(item)
    item.quality += 1
  end

  def decrement_quality(item)
    item.quality -= 1
  end

  def max_quality(item)
    if item.quality > 50 && item.name != "Sulfuras, Hand of Ragnaros"
      item.quality = 50
    end
  end
end
