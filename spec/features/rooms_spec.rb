require 'rails_helper'

RSpec.feature "Rooms", type: :feature do
  background do
    visit root_path
    click_link "新規登録"
    fill_in "名前*", with: "テストユーザー"
    fill_in "Eメールアドレス*", with: "hoge@examle.com"
    fill_in "棋力*", with: "30級"
    fill_in "よく使用するアプリ*", with: "将棋"
    fill_in "よく行う持ち時間*", with: "10分"
    fill_in "自己紹介", with: "初めまして"
    fill_in "パスワード*", with: "password"
    fill_in "パスワード確認用*", with: "password"
    click_button "登録"
    mail = ActionMailer::Base.deliveries.last
    body = mail.body.encoded
    url = body[/http[^"]+/]
    visit url
    fill_in "メールアドレス*", with: "hoge@examle.com"
    fill_in "パスワード*", with: "password"
    click_button "ログイン"
  end
  scenario "部屋が作成されること" do
    click_link "投稿↑"
    fill_in "部屋名*", with: "ノシ将棋部屋"
    fill_in "tags_all", with: "誰でも可"
    fill_in "募集内容", with: "初心者ですが宜しくお願いいたします。"
    expect { click_button "投稿" }.to change { Room.count }.by(1)
  end

  feature "メッセージ送信" do
    background do
      click_link "投稿↑"
      fill_in "部屋名*", with: "ノシ将棋部屋"
      fill_in "tags_all", with: "誰でも可"
      fill_in "募集内容", with: "初心者ですが宜しくお願いいたします。"
      click_button "投稿"
      click_link "show_link"
      click_link "チャットルーム"
    end
    scenario "送信できること" do
      fill_in "message_content", with: "hogehoge"
      expect { click_button "送信" }.to change { Message.count }.by(1)
    end
    scenario "送信に失敗する場合(100文字以上の場合)" do
      fill_in "message_content", with: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
      expect { click_button "送信" }.to change { Message.count }.by(0)
      expect(page).to have_content "メッセージが空白もしくは100文字を超えました。"

      fill_in "message_content", with: ""
      expect { click_button "送信" }.to change { Message.count }.by(0)
      expect(page).to have_content "メッセージが空白もしくは100文字を超えました。"

    end
  end
end
