FactoryBot.define do

  factory :post do
    chess { "30級" }
    app { "将棋" }
    time { "10分" }
    all_tag { "誰でも可" }
    content { "四間飛車募集します。" }
    association :room
    user { room.user }
  end
end
