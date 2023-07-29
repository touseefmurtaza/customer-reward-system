module Rules
  class PurchaseAmount < Base
    def initialize(amount_cents, reward)
      @amount_cents = amount_cents
      @reward = reward
    end

    def matches?(customer_purchase)
      customer_purchase[:purchase_amount_cents] > @amount_cents
    end

    def reward
      @reward
    end
  end
end
