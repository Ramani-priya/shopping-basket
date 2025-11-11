class DeliveryRule
  attr_reader :threshold, :fee

  def initialize(threshold:, fee:)
    @threshold = threshold
    @fee = fee
  end
end
