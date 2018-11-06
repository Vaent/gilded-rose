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
        if item.quality < 50
          increment_quality(item)
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                increment_quality(item)
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                increment_quality(item)
              end
            end
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
          if item.quality < 50
            increment_quality(item)
          end
        end
      end
    end
  end

  def increment_quality(item)
    item.quality += 1
  end

  def decrement_quality(item)
    item.quality -= 1
  end
end
