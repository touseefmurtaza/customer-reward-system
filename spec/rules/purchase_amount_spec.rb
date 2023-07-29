require_relative '../../rules/base'
require_relative '../../rules/purchase_amount'

RSpec.describe Rules::PurchaseAmount do
  let(:amount_cents) { 1500 }
  let(:reward) { "next purchase free" }
  let(:purchase_amount_rule) { Rules::PurchaseAmount.new(amount_cents, reward) }

  describe '#matches?' do
    it 'should return true for purchases above 1500 cents' do
      purchase = { customer_id: 1, purchase_amount_cents: 1800, created_at: Time.utc(2023, 1, 1) }
      expect(purchase_amount_rule.matches?(purchase)).to be true
    end

    it 'should return false for purchases equal to or below 1500 cents' do
      purchase = { customer_id: 1, purchase_amount_cents: 1500, created_at: Time.utc(2023, 1, 1) }
      expect(purchase_amount_rule.matches?(purchase)).to be false
    end
  end

  describe '#reward' do
    it 'should return the correct reward' do
      expect(purchase_amount_rule.reward).to eq(reward)
    end
  end
end
