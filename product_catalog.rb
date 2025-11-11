class ProductCatalog
  attr_reader :products

  def initialize
    @products = []
  end

  def add_product(product)
    @products << product
  end

  def find_product(code)
    @products.find { |p| p.code == code }
  end
end
