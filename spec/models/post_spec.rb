require 'rails_helper'

RSpec.describe Post, type: :model do
  it "chess, app, timeがあれば有効な状態であること" do
    post = create(:post)
    expect(post).to be_valid
  end

  it "chessがなければ無効な状態であること" do
    expect {create(:post, chess: "")}.to raise_error(ActiveRecord::RecordInvalid)
  end

  context "chessの文字数が10文字より多い場合" do
    it "無効な状態であること" do
      expect {create(:post, chess: "12345678910")}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "chessの文字数が10文字以内の場合" do
    it "有効な状態であること" do
      post = create(:post, chess: "1234567890")
      expect(post).to be_valid
    end
  end

  it "appがなければ無効な状態であること" do
    expect {create(:post, app: "")}.to raise_error(ActiveRecord::RecordInvalid)
  end
  context "appの文字数が30文字より多い場合" do
    it "無効な状態であること" do
      expect {create(:post, app: "1234567891234567891234567891234")}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "appの文字数が30文字以内の場合" do
    it "有効な状態であること" do
      post = create(:post, app: "123456789123456789123456789123")
      expect(post).to be_valid
    end
  end

  it "timeがなければ無効な状態であること" do
    expect {create(:post, time: "")}.to raise_error(ActiveRecord::RecordInvalid)
  end
  context "timeの文字数が10文字より多い場合" do
    it "無効な状態であること" do
      expect {create(:post, time: "12345678910")}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "timeの文字数が10文字以内の場合" do
    it "有効な状態であること" do
      post = create(:post, time: "1234567890")
      expect(post).to be_valid
    end
  end
end
