# frozen_string_literal: true

require_relative '../../rules/base'
require_relative '../../rules/may_fourth'

RSpec.describe Rules::MayFourth do
  let(:may_fourth_date) { Time.utc(2023, 5, 4) }
  let(:reward) { 'Star Wars themed item added to delivery' }
  let(:may_fourth_rule) { Rules::MayFourth.new(may_fourth_date, reward) }

  describe '#matches?' do
    it 'should return true for purchases made on May 4th' do
      purchase = { customer_id: 1, purchase_amount_cents: 2500, created_at: Time.utc(2023, 5, 4) }
      expect(may_fourth_rule.matches?(purchase)).to be true
    end

    it 'should return false for purchases made on other dates' do
      purchase = { customer_id: 1, purchase_amount_cents: 2500, created_at: Time.utc(2023, 5, 3) }
      expect(may_fourth_rule.matches?(purchase)).to be false
    end
  end

  describe '#reward' do
    it 'should return the correct reward' do
      expect(may_fourth_rule.reward).to eq(reward)
    end
  end
end
