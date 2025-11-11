class DeliveryRules
  def initialize(rules)
    @rules = rules.sort_by { |r| -r.threshold }
  end

  def fee_for(total)
    rule = @rules.find { |r| total >= r.threshold }
    rule ? rule.fee.to_f : @rules.last.fee.to_f
  end
end
