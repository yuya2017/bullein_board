require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "#index" do
    context "ログインしている状態" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "正常なレスポンスを返すこと" do
        get "/"
        expect(response).to be_successful
      end
      it "200レスポンスを返すこと" do
        get "/"
        expect(response.status).to eq 200
      end
    end
    context "ログインしていない状態" do
      it "正常なレスポンスを返すこと" do
        get "/"
        expect(response).to be_successful
      end
      it "200レスポンスを返すこと" do
        get "/"
        expect(response.status).to eq 200
      end
    end
  end

  describe "#new" do
    context "ログインしている状態" do
      before do
        @user = create(:user)
        sign_in @user
      end
      it "正常なレスポンスを返すこと" do
        get "/posts/new"
        expect(response).to be_successful
      end
      it "200レスポンスを返すこと" do
        get "/posts/new"
        expect(response.status).to eq 200
      end
    end
    context "ログインしていない状態" do
      it "302レスポンスを返すこと" do
        get "/posts/new"
        expect(response.status).to eq 302
      end
      it "ホーム画面へリダイレクトされること" do
        get "/posts/new"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#create" do
    context "ログインしている状態" do
      it "正常に保存できること" do
        expect{ create(:room, post: create(:post, :post_with_user), name: "将棋") }.to change { Post.count }.by(1).and change { Room.count }.by(1)
      end
    end
    context "ログインしていない状態"do
      it "保存できないこと" do
        expect{ create(:room, post: create(:post), name: "将棋") }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#show" do
    context "ログインしている状態" do
      before do
        @post = create(:post, :post_with_user)
        sign_in @post.user
        create(:room, post: @post, name: "ノシ将棋")
      end
      it "正常なレスポンスを返すこと" do
        get "/posts/#{@post.id}"
        expect(response).to be_successful
      end
      it "200レスポンスを返すこと" do
        get "/posts/#{@post.id}"
        expect(response.status).to eq 200
      end
    end
    context "ログインしていない状態" do
      before do
        @post = create(:post, :post_with_user)
        create(:room, post: @post, name: "ノシ将棋")
      end
      it "正常なレスポンスを返すこと" do
        get "/posts/#{@post.id}"
        expect(response).to be_successful
      end
      it "200レスポンスを返すこと" do
        get "/posts/#{@post.id}"
        expect(response.status).to eq 200
      end
    end
  end

  describe "#update" do
    context "投稿と同じユーザーでログインしている状態" do
      
    end
  end

end
