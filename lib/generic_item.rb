class GenericItem<Item
  MAXIMUM_QUALITY = 50
  MINIMUM_QUALITY = 0
  DECAY_RATE = -1

  def daily_update
    @sell_in -= 1
    decay_amount = get_decay_amount
    apply_decay(decay_amount)
  end

  private

  def get_decay_amount
    self.class::DECAY_RATE * (past_sell_in? ? 2 : 1)
  end

  def past_sell_in?
    @sell_in < 0
  end

  def apply_decay(decay_amount)
    @quality += decay_amount
    limit_quality
  end

  def limit_quality
    @quality = @quality.clamp(self.class::MINIMUM_QUALITY, self.class::MAXIMUM_QUALITY)
  end
end
