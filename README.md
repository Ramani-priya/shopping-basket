# Acme Widget Co — Basket PoC

Small Ruby proof‑of‑concept for a shopping basket with:
- Product catalog injection
- Delivery rules (threshold → fee)
- Offer engine (strategy pattern)
- Basket item-level quantity and per-item price override
- Deterministic rounding of discounts
  
## Design notes / assumptions
- Basket is initialized with a ProductCatalog, DeliveryRules and BasketOffers (dependency injection).
- BasketItem stores its own price and quantity. Price passed to add_item overrides Product.price.
- Offers are independent strategy objects implementing `discount(basket)` and return a numeric discount in dollars.
- Offer discounts are rounded to 2 decimal places (cents) before being applied to the subtotal — this matches the provided expected outputs.
- Delivery fee is calculated on subtotal after discounts.
- No external persistence or frameworks — simple objects in memory.

## Files of interest
- product.rb, product_catalog.rb
- basket_item.rb, basket.rb
- offer.rb, buy_one_get_one_half_offer.rb
- delivery_rule.rb, delivery_rules.rb
- basket_offers.rb
- data_intialiser.rb — builds environment and runs example baskets
- test_assertions.rb — simple test runner that prints expected / actual and PASS/FAIL

## Requirements
- Ruby 2.5+ (tested with Ruby 2.7+)

## Run the examples
Open Terminal in the project root (Mac):

- Run example baskets:
  ruby data_intialiser.rb

- Run the simple assertions test:
  ruby test_assertions.rb

## Extending
- Add more Offer subclasses (implement `discount(basket)`).
- Replace ProductCatalog implementation with a DB-backed repository; keep the same public interface.
- Add an RSpec or Minitest suite for more precise unit tests.
