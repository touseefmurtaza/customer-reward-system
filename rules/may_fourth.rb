module Rules
  class MayFourth < Base
    def initialize(may_fourth, reward)
      @may_fourth = may_fourth
      @reward = reward
    end

    def matches?(customer_purchase)
      customer_purchase[:created_at].day == @may_fourth.day && customer_purchase[:created_at].month == @may_fourth.month
    end

    def reward
      @reward
    end
  end
end
