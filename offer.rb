class Offer
  def discount(cart)
    raise NotImplementedError, "Subclasses must implement the discount method"
  end
end