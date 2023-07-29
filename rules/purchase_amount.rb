# frozen_string_literal: true

module Rules
  class PurchaseAmount < Base
    def initialize(amount_cents, reward) # rubocop:disable Lint/MissingSuper
      @amount_cents = amount_cents
      @reward = reward
    end

    def matches?(customer_purchase)
      customer_purchase[:purchase_amount_cents] > @amount_cents
    end

    attr_reader :reward
  end
end
