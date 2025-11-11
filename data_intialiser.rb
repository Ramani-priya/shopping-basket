# Data initializer and small script to exercise the baskets.

require_relative 'product'
require_relative 'product_catalog'
require_relative 'delivery_rule'
require_relative 'delivery_rules'
require_relative 'offer'
require_relative 'buy_one_get_one_half_offer'
require_relative 'basket_offers'
require_relative 'basket'
require_relative 'basket_item'

def build_environment
  # products
  r01 = Product.new('R01', 'Red Widget', 32.95)
  g01 = Product.new('G01', 'Green Widget', 24.95)
  b01 = Product.new('B01', 'Blue Widget', 7.95)

  # product catalog
  catalog = ProductCatalog.new
  [r01, g01, b01].each { |p| catalog.add_product(p) }

  # delivery rules: threshold => fee
  rules = [
    DeliveryRule.new(threshold: 90, fee: 0.0),
    DeliveryRule.new(threshold: 50, fee: 2.95),
    DeliveryRule.new(threshold: 0,  fee: 4.95)
  ]
  delivery_rules = DeliveryRules.new(rules)

  # offers
  r01_bogohalf = BuyOneGetOneHalfOffer.new('R01')

  { catalog: catalog, delivery_rules: delivery_rules, offers: [r01_bogohalf] }
end

def new_basket(env)
  b = Basket.new(product_catalog: env[:catalog], delivery_rules: env[:delivery_rules], basket_offers: nil)
  # wire offers after basket creation so offers can reference the basket
  b.basket_offers = BasketOffers.new(b, env[:offers])
  b
end

def run_examples(print: true)
  env = build_environment

  examples = [
    { items: %w[B01 G01], expected: 37.85 },
    { items: %w[R01 R01], expected: 54.37 },
    { items: %w[R01 G01], expected: 60.85 },
    { items: %w[B01 B01 R01 R01 R01], expected: 98.27 }
  ]

  results = examples.map.with_index(1) do |ex, idx|
    basket = new_basket(env)
    ex[:items].each { |code| basket.add_item(code) }
    actual = basket.total
    { id: idx, items: ex[:items], expected: ex[:expected], actual: actual }
  end

  if print
    results.each do |r|
      puts "Basket #{r[:id]} - items: #{r[:items].join(', ')}"
      puts "  expected: $#{'%.2f' % r[:expected]}  actual: $#{'%.2f' % r[:actual]} #{r[:expected].round(2) == r[:actual].round(2) ? 'PASS' : 'FAIL'}"
    end
  end

  results
end

if __FILE__ == $0
  run_examples
end
