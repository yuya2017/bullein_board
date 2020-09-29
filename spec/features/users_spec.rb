require 'rails_helper'

RSpec.feature "Users", type: :feature do
  feature "ログイン、ログアウト" do
    background do
      @user = create(:user)
    end
    scenario "ログイン" do
      visit root_path
      click_link "ログイン"
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
      expect(page).to have_content "ログインしました"
    end
    scenario "ログアウト" do
      visit root_path
      click_link "ログイン"
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
      click_link "ログアウト"
      expect(page).to have_content "ログアウトしました"
    end
  end

  feature "アカウント登録、アカウント削除" do
    scenario "アカウント登録" do
      visit root_path
      click_link "新規登録"
      fill_in "名前*", with: "テストユーザー"
      fill_in "Eメールアドレス*", with: "tester@examle.com"
      fill_in "棋力*", with: "30級"
      fill_in "よく使用するアプリ*", with: "将棋"
      fill_in "よく行う持ち時間*", with: "10分"
      fill_in "自己紹介", with: "初めまして"
      fill_in "パスワード*", with: "password"
      fill_in "パスワード確認用*", with: "password"
      expect { click_button '登録' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
