# frozen_string_literal: true

require_relative 'customer_reward_system'
require_relative 'customer_purchases_data'
require_relative 'rule_configurations'
require_relative './rules/base'
require_relative './rules/purchase_amount'
require_relative './rules/second_purchase'
require_relative './rules/may_fourth'

reward_system = CustomerRewardSystem.new

# Dynamically add rules based on the configuration
RULE_CONFIGURATIONS.each do |config|
  case config[:type]
  when :purchase_amount_rule
    reward_system.add_rule(Rules::PurchaseAmount.new(config[:amount_cents], config[:reward]))
  when :second_purchase_rule
    reward_system.add_rule(Rules::SecondPurchase.new(config[:thirty_days_window], config[:reward]))
  when :may_fourth_rule
    reward_system.add_rule(Rules::MayFourth.new(config[:may_fourth], config[:reward]))
  else
    raise "Unsupported rule type: #{config[:type]}"
  end
end

# Applying rewards to customer purchases
CUSTOMER_PURCHASES.each do |purchase|
  reward = reward_system.apply_reward(purchase)
  if reward
    puts "Customer ID #{purchase[:customer_id]}: 🚀 #{reward}"
  else
    puts "Customer ID #{purchase[:customer_id]}: No reward applicable"
  end
end
