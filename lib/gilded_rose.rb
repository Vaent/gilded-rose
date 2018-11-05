class GildedRose

  def initialize(items) #requires a list of items at creation
    @items = items
  end

  def update_quality
    @items.each do |item|
      # standard items within sell by date
      # declare exceptions to standard item behaviour
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        # checks quality is above zero
        if item.quality > 0
          # checks for legendary item (further exception)
          if item.name != "Sulfuras, Hand of Ragnaros"
            # decrement quality by 1
            item.quality = item.quality - 1
          end
        end
      # end standard item handling
      else
        # checks quality is below 50
        if item.quality < 50
          # increment quality by 1
          item.quality = item.quality + 1
          # backstage pass handling
          # check whether the item is a backstage pass
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            # check whether 10 or less days to expiry
            if item.sell_in < 11
              # repeat check that quality is below 50
              if item.quality < 50
                # increment quality
                item.quality = item.quality + 1
              end
            end
            # check whether 5 or fewer days to expiry
            if item.sell_in < 6
              # check quality is still below 50
              if item.quality < 50
                # increment quality
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      # check the item is not legendary
      if item.name != "Sulfuras, Hand of Ragnaros"
        # decrement sell by date
        item.sell_in = item.sell_in - 1
      end
      # check whether the sell by date has passed
      if item.sell_in < 0
        # check the item is not Aged Brie
        if item.name != "Aged Brie"
          # check the item is not a backstage pass
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            # check quality is greater than zero
            if item.quality > 0
              # check item is not legendary
              if item.name != "Sulfuras, Hand of Ragnaros"
                # this line only applies to standard items, past the sell by date, with quality greater than zero
                # decrement quality
                item.quality = item.quality - 1
              end
            end
          else
            # if the item is a backstage pass (and past the sell by date)
            # set item quality to zero
            item.quality = item.quality - item.quality
          end
        else
          # if the item is Aged Brie past the sell by date
          # and the quality is less than 50
          if item.quality < 50
            # increment quality
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end
