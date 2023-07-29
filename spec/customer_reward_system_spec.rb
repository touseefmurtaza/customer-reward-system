require_relative '../customer_reward_system'

RSpec.describe CustomerRewardSystem do
  let(:reward_system) { CustomerRewardSystem.new }

  describe '#add_rule' do
    it 'should add a rule to the system' do
      rule = instance_double('Rules::PurchaseAmount')
      reward_system.add_rule(rule)
      expect(reward_system.instance_variable_get(:@rules)).to include(rule)
    end
  end

  describe '#apply_reward' do
    it 'should return nil if no rule matches' do
      customer_purchase = { customer_id: 1, purchase_amount_cents: 1000, created_at: Time.utc(2023, 1, 1) }
      expect(reward_system.apply_reward(customer_purchase)).to be_nil
    end

    it 'should return the reward from the last matching rule' do
      rule1 = instance_double('Rules::PurchaseAmount', matches?: false)
      rule2 = instance_double('Rules::SecondPurchase', matches?: true, reward: '20% off')
      rule3 = instance_double('Rules::MayFourth', matches?: true, reward: 'Star Wars item')
      reward_system.add_rule(rule1)
      reward_system.add_rule(rule2)
      reward_system.add_rule(rule3)

      customer_purchase = { customer_id: 1, purchase_amount_cents: 2000, created_at: Time.utc(2023, 5, 4) }
      expect(reward_system.apply_reward(customer_purchase)).to eq('Star Wars item')
    end

    it 'should return nil if no rule matches' do
      rule1 = instance_double('Rules::PurchaseAmount', matches?: false)
      rule2 = instance_double('Rules::SecondPurchase', matches?: false)
      rule3 = instance_double('Rules::MayFourth', matches?: false)
      reward_system.add_rule(rule1)
      reward_system.add_rule(rule2)
      reward_system.add_rule(rule3)

      customer_purchase = { customer_id: 1, purchase_amount_cents: 1000, created_at: Time.utc(2023, 1, 1) }
      expect(reward_system.apply_reward(customer_purchase)).to be_nil
    end
  end
end
