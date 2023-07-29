# frozen_string_literal: true

module Rules
  class Base
    def matches?(customer_purchase)
      raise NotImplementedError, "#{self.class} must implement 'matches?' method."
    end

    def reward
      raise NotImplementedError, "#{self.class} must implement 'reward' method."
    end
  end
end
