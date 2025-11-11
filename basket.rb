class Basket
  attr_reader :basket_items
  attr_accessor :delivery_rules, :basket_offers

  def initialize(product_catalog:, delivery_rules: nil, basket_offers: nil)
    @basket_items = []
    @product_catalog = product_catalog
    @delivery_rules = delivery_rules
    @basket_offers = basket_offers
  end

  def add_item(code, quantity = 1, price: nil)
    @basket_items << initialize_item(code, quantity, price)
  end

  def total
    subtotal = @basket_items.sum(&:total_price)
    discounts = apply_discounts
    subtotal_after_discount = subtotal - discounts
    delivery = apply_delivery_fee(subtotal_after_discount)
    (subtotal_after_discount + delivery).round(2)
  end

  private

  def initialize_item(code, quantity, price)
    product = @product_catalog.find_product(code) || raise("Product #{code} not found")
    BasketItem.new(product, quantity, price)
  end

  def apply_delivery_fee(subtotal_after_discount)
    return 0 unless @delivery_rules
    @delivery_rules.fee_for(subtotal_after_discount)
  end

  def apply_discounts
    return 0 unless @basket_offers
    @basket_offers.apply_offers
  end
end
