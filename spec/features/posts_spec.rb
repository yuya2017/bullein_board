require 'rails_helper'

RSpec.feature "Posts", type: :feature do
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

  feature "新規投稿" do
    scenario "投稿が成功する場合" do
      click_link "投稿↑"
      fill_in "部屋名*", with: "ノシ将棋部屋"
      fill_in "tags_all", with: "誰でも可"
      fill_in "募集内容", with: "初心者ですが宜しくお願いいたします。"
      expect { click_button "投稿" }.to change { Post.count }.by(1)
      expect(page).to have_content "テストユーザーがノシ将棋部屋を作成しました。"
    end

    scenario "投稿に失敗した場合" do
      click_link "投稿↑"
      fill_in "部屋名*", with: ""
      fill_in "tags_all", with: "誰でも可"
      fill_in "募集内容", with: "初心者ですが宜しくお願いいたします。"
      click_button "投稿"
      expect(page).to have_content "部屋名を入力してください"

      fill_in "部屋名*", with: "ノシ将棋部屋"
      fill_in "棋力*", with: ""
      click_button "投稿"
      expect(page).to have_content "棋力を入力してください"

      fill_in "使用するアプリ*", with: ""
      click_button "投稿"
      expect(page).to have_content "アプリ名を入力してください"

      fill_in "対戦時間*", with: ""
      click_button "投稿"
      expect(page).to have_content "対戦時間を入力してください"

      fill_in "部屋名*", with: "1234567890123"
      click_button "投稿"
      expect(page).to have_content "部屋名は12文字以内にしてください"

      fill_in "部屋名*", with: "123456789012"
      fill_in "棋力*", with: "123456787901"
      click_button "投稿"
      expect(page).to have_content "棋力は10文字以内にしてください"

      fill_in "使用するアプリ*", with: "1234567891234567891234567891234"
      click_button "投稿"
      expect(page).to have_content "アプリ名は30文字以内にしてください"

      fill_in "対戦時間*", with: "123456787901"
      click_button "投稿"
      expect(page).to have_content "対戦時間は10文字以内にしてください"

      fill_in "tags_all", with: "123456789012345678901"
      click_button "投稿"
      expect(page).to have_content "タグは合計20文字以内にしてください"

      fill_in "tags_all", with: "12345678901234567890"
      fill_in "募集内容", with: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
      click_button "投稿"
      expect(page).to have_content "募集内容は100文字以内にしてください"
    end
  end

  feature "投稿編集" do
    background do
      click_link "投稿↑"
      fill_in "部屋名*", with: "ノシ将棋部屋"
      fill_in "tags_all", with: "誰でも可"
      fill_in "募集内容", with: "初心者ですが宜しくお願いいたします。"
      click_button "投稿"
    end

    scenario "作成したユーザー以外は「編集」が表示されない" do
      click_link "ログアウト"
      click_link "新規登録"
      fill_in "名前*", with: "テストユーザー2"
      fill_in "Eメールアドレス*", with: "foo@examle.com"
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
      click_link "show_link"
      expect(find("#show-main")).not_to have_content "編集"
    end

    scenario "作成したユーザーであれば「編集」が表示されること" do
      click_link "show_link"
      expect(find("#show-main")).to have_content "編集"
    end

    scenario "編集に成功する場合" do
      click_link "show_link"
      click_link "編集"
      fill_in "部屋名*", with: "ノシ将棋2"
      fill_in "棋力*", with: "31級"
      fill_in "使用するアプリ*", with: "将棋オンライン"
      fill_in "対戦時間*", with: "3分"
      fill_in "tags_all", with: "玄人のみ"
      fill_in "募集内容", with: "経験者募集"
      click_button "編集"
      expect(page).to have_content "更新しました。"
    end

    scenario "編集に失敗する場合" do
      click_link "show_link"
      click_link "編集"
      fill_in "部屋名*", with: "1234567890123"
      click_button "編集"
      expect(page).to have_content "部屋名は12文字以内にしてください"

      fill_in "部屋名*", with: "123456789012"
      fill_in "棋力*", with: "123456787901"
      click_button "編集"
      expect(page).to have_content "棋力は10文字以内にしてください"

      fill_in "使用するアプリ*", with: "1234567891234567891234567891234"
      click_button "編集"
      expect(page).to have_content "アプリ名は30文字以内にしてください"

      fill_in "対戦時間*", with: "123456787901"
      click_button "編集"
      expect(page).to have_content "対戦時間は10文字以内にしてください"

      fill_in "tags_all", with: "123456789012345678901"
      click_button "編集"
      expect(page).to have_content "タグは合計20文字以内にしてください"

      fill_in "tags_all", with: "12345678901234567890"
      fill_in "募集内容", with: "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
      click_button "編集"
      expect(page).to have_content "募集内容は100文字以内にしてください"
    end

    scenario "投稿を削除できること" do
      click_link "show_link"
      click_link "編集"
      click_link "削除"
      expect(page).to have_content "「ノシ将棋部屋」が削除されました。"
    end
  end
end
