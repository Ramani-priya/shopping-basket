class BasketItem
  attr_reader :product, :quantity, :price

  def initialize(product, quantity = 1, price = nil)
    @product = product
    @quantity = quantity
    @price = price || product.price
  end

  def total_price
    @price * @quantity
  end

  def code
    @product.code
  end
end
