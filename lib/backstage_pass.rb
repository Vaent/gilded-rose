class BackstagePass<GenericItem
  def daily_update
    @sell_in -= 1
    return @quality = 0 if sell_in < 0
    decay_amount = get_decay_amount
    apply_decay(decay_amount)
  end

  def get_decay_amount
    return 1 if sell_in > 10
    return 2 if sell_in > 5
    return 3 if sell_in > 0
  end
end
