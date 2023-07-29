RULE_CONFIGURATIONS = [
  { type: :purchase_amount_rule, amount_cents: 1500, reward: "next purchase free" },
  { type: :second_purchase_rule, thirty_days_window: 30 * 24 * 60 * 60, reward: "twenty percent off next order" },
  { type: :may_fourth_rule, may_fourth: Time.utc(0, 5, 4, 0, 0), reward: "Star Wars themed item added to delivery" }
]
