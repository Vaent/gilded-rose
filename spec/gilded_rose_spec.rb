require 'gilded_rose'
require 'item'

describe GildedRose do
  max_quality = GildedRose::MAXIMUM_QUALITY
  min_quality = GildedRose::MINIMUM_QUALITY

  describe "#update_quality" do
    it "does not change the name" do
      item = Item.new("foo", 0, min_quality)
      GildedRose.new([item]).update_quality
      expect(item.name).to eq "foo"
    end

    it "lowers the sell_in by one after a day" do
      item = Item.new("item", 1, min_quality)
      GildedRose.new([item]).update_quality
      expect(item.sell_in).to eq 0
    end

    it "never lowers quality below the minimum" do
      item = Item.new("item", 0, min_quality)
      GildedRose.new([item]).update_quality
      expect(item.quality).to eq(min_quality)
    end

    context 'when item is generic' do
      context 'before sell_in' do
        it 'lowers quality by one after one day' do
          item = Item.new("item", 1, min_quality + 1)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality)
        end
      end

      context 'after sell_in' do
        it 'lowers quality by two after a day' do
          item = Item.new("item", 0, min_quality + 2)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality)
        end
      end
    end

    context 'when item is Aged Brie' do
      context 'before sell_in' do
        it 'raises quality by one after a day' do
          item = Item.new("Aged Brie", 1, min_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality + 1)
        end

        it 'never raises quality beyond the maximum' do
          item = Item.new("Aged Brie", 1, max_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(max_quality)
        end
      end

      context 'after sell_in' do
        it 'raises quality by two after a day' do
          item = Item.new("Aged Brie", 0, min_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality + 2)
        end

        it 'only raises quality to the maximum when already one below that' do
          item = Item.new("Aged Brie", 0, max_quality - 1)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(max_quality)
        end
      end
    end

    context 'when item is Sulfuras, Hand of Ragnaros' do
      it 'does not change sell_in' do
        item = Item.new("Sulfuras, Hand of Ragnaros", 1, 80)
        GildedRose.new([item]).update_quality
        expect(item.sell_in).to eq(1)
      end

      it 'does not change quality' do
        item = Item.new("Sulfuras, Hand of Ragnaros", 1, 80)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(80)
      end
    end

    context 'when item is Backstage passes to a TAFKAL80ETC concert' do
      context 'when sell_in is greater than 10' do
        it 'increases quality by one after each day' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, min_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality + 1)
        end

        it 'never increases quality beyond the maximum' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, max_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(max_quality)
        end
      end

      context 'when sell_in is less than or equal to 10 but more than 5' do
        it 'increases quality by two after each day' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, min_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality + 2)
        end

        it 'only raises quality to the maximum when already one below that' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, max_quality - 1)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(max_quality)
        end
      end

      context 'when sell_in is less than or equal to 5 but more than 0' do
        it 'increases quality by three after each day' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, min_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(min_quality + 3)
        end

        it 'only raises quality to the maximum when already two below that' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, max_quality - 2)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(max_quality)
        end
      end

      context 'after sell_in' do
        it 'sets quality to 0' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, max_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(0)
        end

        it 'does not change quality' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, min_quality)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(0)
        end
      end
    end
  end
end
