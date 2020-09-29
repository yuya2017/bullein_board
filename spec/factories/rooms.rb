FactoryBot.define do
  factory :room do
    name { "ノシ将棋" }
    association :user
    end
end
