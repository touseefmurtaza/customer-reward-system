# frozen_string_literal: true

require_relative '../../rules/base'
require_relative '../../rules/second_purchase'

RSpec.describe Rules::SecondPurchase do # rubocop:disable Metrics/BlockLength
  let(:thirty_days_window) { 30 * 24 * 60 * 60 }
  let(:reward) { 'twenty percent off next order' }
  let(:second_purchase_rule) { Rules::SecondPurchase.new(thirty_days_window, reward) }

  describe '#matches?' do
    it 'should return true for the second purchase within 30 days' do
      purchases = [
        { customer_id: 1, purchase_amount_cents: 1000, created_at: Time.utc(2023, 1, 1) },
        { customer_id: 1, purchase_amount_cents: 2000, created_at: Time.utc(2023, 1, 15) }
      ]
      matching_purchase = { customer_id: 1, purchase_amount_cents: 3000, created_at: Time.utc(2023, 1, 25) }

      purchases.each { |purchase| second_purchase_rule.matches?(purchase) }

      expect(second_purchase_rule.matches?(matching_purchase)).to be true
    end

    it 'should return false for the third purchase or after 30 days' do
      purchases = [
        { customer_id: 1, purchase_amount_cents: 1000, created_at: Time.utc(2023, 1, 1) },
        { customer_id: 1, purchase_amount_cents: 2000, created_at: Time.utc(2023, 2, 1) }
      ]
      non_matching_purchase = { customer_id: 1, purchase_amount_cents: 3000, created_at: Time.utc(2023, 4, 10) }

      purchases.each { |purchase| second_purchase_rule.matches?(purchase) }

      expect(second_purchase_rule.matches?(non_matching_purchase)).to be false
    end
  end

  describe '#reward' do
    it 'should return the correct reward' do
      expect(second_purchase_rule.reward).to eq(reward)
    end
  end
end
