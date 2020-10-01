require 'rails_helper'

RSpec.feature "Users", type: :feature do

  feature "登録、ログインに成功する場合" do
    scenario "アカウント登録" do
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
      expect { click_button '登録' }.to change { ActionMailer::Base.deliveries.size }.by(1)

      mail = ActionMailer::Base.deliveries.last
      body = mail.body.encoded
      url = body[/http[^"]+/]
      visit url
      expect(page).to have_content 'メールアドレスが確認できました。'

      fill_in "メールアドレス*", with: "hoge@examle.com"
      fill_in "パスワード*", with: "password"
      click_button "ログイン"
      expect(page).to have_content "ログインしました"

      click_link "ログアウト"
      expect(page).to have_content "ログアウトしました"
    end
  end

  feature "登録、ログインに失敗する場合" do
    scenario "アカウント登録" do
      visit root_path
      click_link "新規登録"
      fill_in "名前*", with: ""
      fill_in "Eメールアドレス*", with: "hoge@examle.com"
      fill_in "棋力*", with: "30級"
      fill_in "よく使用するアプリ*", with: "将棋"
      fill_in "よく行う持ち時間*", with: "10分"
      fill_in "自己紹介", with: "初めまして"
      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      expect(page).to have_content "ユーザー名を入力してください"

      fill_in "名前*", with: "テスト"
      fill_in "Eメールアドレス*", with: ""
      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      expect(page).to have_content "メールアドレスを入力してください"

      fill_in "Eメールアドレス*", with: "hoge@examle.com"
      fill_in "棋力*", with: ""
      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      expect(page).to have_content "棋力を入力してください"

      fill_in "棋力*", with: "30級"
      fill_in "よく使用するアプリ*", with: ""
      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      expect(page).to have_content "アプリ名を入力してください"

      fill_in "よく使用するアプリ*", with: "将棋"
      fill_in "よく行う持ち時間*", with: ""
      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      expect(page).to have_content "持ち時間を入力してください"

      fill_in "よく行う持ち時間*", with: "10分"
      fill_in "パスワード*", with: ""
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      expect(page).to have_content "パスワードを入力してください"

      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: ""
      click_button "登録"
      expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"

      fill_in "パスワード*", with: "pass"
      fill_in "パスワード確認用*", with: "pass"
      click_button "登録"
      expect(page).to have_content "パスワードは8文字以上で入力してください"

      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      click_button "登録"
      mail = ActionMailer::Base.deliveries.last
      body = mail.body.encoded
      url = body[/http[^"]+/]
      visit url
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
      expect(page).to have_content "メールアドレスはすでに存在します"
    end

    scenario "ログイン" do
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
      fill_in "メールアドレス*", with: "foo@examle.com"
      fill_in "パスワード*", with: "password"
      click_button "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"

      fill_in "メールアドレス*", with: "hoge@examle.com"
      fill_in "パスワード*", with: "hogehoge"
      click_button "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end
  end

  feature "ゲストログイン" do
    scenario "ゲストログイン" do
      visit root_path
      click_link "ログイン"
      expect { click_link "ゲストログイン（閲覧用）" }.to change { User.count }.by(1)
      expect(page).to have_content "ゲストユーザーとしてログインしました。"

      click_link "ログアウト"
      click_link "ログイン"
      expect { click_link "ゲストログイン（閲覧用）" }.to change { User.count }.by(0)
    end
  end
end
