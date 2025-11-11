class BasketOffers
  def initialize(basket, offers)
    @basket = basket
    @offers = offers
  end

  def apply_offers
    @offers.sum { |offer| ((offer.discount(@basket) || 0).to_f).round(2) }
  end
end