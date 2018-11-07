class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      break if item.name == "Sulfuras, Hand of Ragnaros"
      item.sell_in -= 1

      case item.name
      when "Aged Brie"
        if item.sell_in < 0
          change_quality(item, 2)
        else
          change_quality(item, 1)
        end
      when "Backstage passes to a TAFKAL80ETC concert"
        if item.sell_in < 0
          item.quality = 0
        elsif item.sell_in < 6
          change_quality(item, 3)
        elsif item.sell_in < 11
          change_quality(item, 2)
        else
          change_quality(item, 1)
        end
      else
        if item.sell_in < 0
          change_quality(item, -2)
        else
          change_quality(item, -1)
        end
      end

      limit_quality(item)
    end
  end

  def change_quality(item, multiplier)
    item.quality += multiplier
  end

  def limit_quality(item)
    item.quality = item.quality.clamp(0, 50)
  end
end
