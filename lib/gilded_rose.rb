class GildedRose
  MAXIMUM_QUALITY = 50
  MINIMUM_QUALITY = 0

  def initialize(items)
    @items = items
    @exceptions = { "Sulfuras, Hand of Ragnaros" => :sulfuras,
      "Aged Brie" => :aged_brie,
      "Backstage passes to a TAFKAL80ETC concert" => :backstage_pass
      }
  end

  def update_quality
    @items.each do |item|
      if @exceptions.include? item.name
        break if @exceptions[item.name] == :sulfuras
        item_type = @exceptions[item.name]
      else
        item_type = :generic_item
      end
      change = send item_type, item.sell_in
      item.sell_in -= 1
      change_quality(item, change)
      limit_quality(item)
    end
  end

  def change_quality(item, amount)
    item.quality += amount
  end

  def limit_quality(item)
    item.quality = item.quality.clamp(MINIMUM_QUALITY, MAXIMUM_QUALITY)
  end

  def aged_brie(sell_in)
    return - generic_item(sell_in)
  end

  def backstage_pass(sell_in)
    return 1 if sell_in > 10
    return 2 if sell_in > 5
    return 3 if sell_in > 0
    return -MAXIMUM_QUALITY
  end

  def generic_item(sell_in)
    return -1 if sell_in > 0
    return -2
  end
end
