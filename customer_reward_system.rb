class CustomerRewardSystem
  def initialize
    @rules = []
  end

  def add_rule(rule)
    @rules << rule
  end

  def apply_reward(customer_purchase)
    matching_rules = @rules.select { |rule| rule.matches?(customer_purchase) }
    return nil if matching_rules.empty?

    matching_rules.last.reward
  end
end
