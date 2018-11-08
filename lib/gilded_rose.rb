class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.daily_update
    end
  end
end
