# frozen_string_literal: true

module Rules
  class SecondPurchase < Base
    def initialize(thirty_days_window, reward) # rubocop:disable Lint/MissingSuper
      @thirty_days_window = thirty_days_window
      @reward = reward
    end

    def matches?(customer_purchase)
      customer_id = customer_purchase[:customer_id]
      purchase_date = customer_purchase[:created_at]

      last_purchase_date = self.class.last_purchase_dates[customer_id]
      self.class.last_purchase_dates[customer_id] = purchase_date
      if last_purchase_date && (purchase_date - last_purchase_date) <= @thirty_days_window
        true
      else
        false
      end
    end

    attr_reader :reward

    def self.last_purchase_dates
      @last_purchase_dates ||= Hash.new { |hash, key| hash[key] = nil }
    end
  end
end
