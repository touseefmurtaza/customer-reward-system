# frozen_string_literal: true

module Rules
  class MayFourth < Base
    def initialize(may_fourth, reward) # rubocop:disable Lint/MissingSuper
      @may_fourth = may_fourth
      @reward = reward
    end

    def matches?(customer_purchase)
      customer_purchase[:created_at].day == @may_fourth.day && customer_purchase[:created_at].month == @may_fourth.month
    end

    attr_reader :reward
  end
end
