class BuyOneGetOneHalfOffer
  def initialize(product_code)
    @product_code = product_code
  end

  def discount(basket)
    items = basket.basket_items.select { |item| item.code == @product_code }
    total_units = items.sum(&:quantity)
    return 0 if total_units < 2

    half_price_count = total_units / 2
    unit_price = items.first.price.to_f
    half_price_count * (unit_price / 2)
  end
end