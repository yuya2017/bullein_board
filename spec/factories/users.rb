FactoryBot.define do
  factory :user do
    username { "test" }
    sequence(:email) { |n| "tester#{n}@example.com"}
    # email { "tester@example.com" }
    chess { "30級" }
    app { "将棋" }
    time { "10分" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end
