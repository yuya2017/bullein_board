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
  describe "#show" do
    context "ログインしている状態" do
      before do
        @user = create(:user)
        @post = create(:post, user: @user)
        sign_in @user
      end
      it "正常なレスポンスを返すこと" do
        get "/posts/show", params: {id: @post.id}
        expect(response).to be_successful
      end
    end
  end
end
        # it "200レスポンスを返すこと" do
        #   get "/posts/show", params: {id: @post.id}
        #   expect(response.status).to eq 200
        # end

      #   it "302レスポンスを返すこと" do
      #     get "/posts/new"
      #     expect(response.status).to eq 302
      #   end
      #   it "ホーム画面へリダイレクトされること" do
      #     get "/posts/new"
      #     expect(response).to redirect_to "/users/sign_in"
      #   end
      # end
