require 'rails_helper'

RSpec.describe User, type: :model do
  it "user、email、chess、app、time、password、password_confirmation、confirmed_atがあれば有効な状態であること" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "usernameがなければ無効な状態であること" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("を入力してください")
  end
  context "usernameの文字数が10文字より多い場合" do
    it "無効な状態であること" do
      user = build(:user, username: "12345678910")
      user.valid?
      expect(user.errors[:username]).to include("は10文字以内にしてください")
    end
  end
  context "usernameの文字数が10文字以内の場合" do
    it "有効な状態であること" do
      user = build(:user, username: "1234567890")
      expect(user).to be_valid
    end
  end

  it "emailがなければ無効な状態であること" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  it "emailに「@」がないと無効な状態であること" do
    user = build(:user, email: "aaa")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  it "chessがなければ無効な状態であること" do
    user = build(:user, chess: nil)
    user.valid?
    expect(user.errors[:chess]).to include("を入力してください")
  end
  context "chessの文字数が10文字より多い場合" do
    it "無効な状態であること" do
      user = build(:user, chess:"12345678910")
      user.valid?
      expect(user.errors[:chess]).to include("は10文字以内にしてください")
    end
  end
  context "chessの文字数が10文字以内の場合" do
    it "有効な状態であること" do
      user = build(:user, chess: "1234567890")
      expect(user).to be_valid
    end
  end

  it "appがなければ無効な状態であること" do
    user = build(:user, app: nil)
    user.valid?
    expect(user.errors[:app]).to include("を入力してください")
  end
  context "appの文字数が30文字より多い場合" do
    it "無効な状態であること" do
      user = build(:user, app:"1234567891234567891234567891234")
      user.valid?
      expect(user.errors[:app]).to include("は30文字以内にしてください")
    end
  end
  context "appの文字数が30文字以内の場合" do
    it "有効な状態であること" do
      user = build(:user, app: "123456789123456789123456789123")
      expect(user).to be_valid
    end
  end

  it "timeがなければ無効な状態であること" do
    user = build(:user, time: nil)
    user.valid?
    expect(user.errors[:time]).to include("を入力してください")
  end
  context "timeの文字数が10文字より多い場合" do
    it "無効な状態であること" do
      user = build(:user, time:"12345678910")
      user.valid?
      expect(user.errors[:time]).to include("は10文字以内にしてください")
    end
  end
  context "timeの文字数が10文字以内の場合" do
    it "有効な状態であること" do
      user = build(:user, time: "1234567890")
      expect(user).to be_valid
    end
  end

  context "contentの文字数が100文字より多い場合" do
    it "無効な状態であること" do
      user = build(:user, content:"12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901")
      user.valid?
      expect(user.errors[:content]).to include("は100文字以内にしてください")
    end
  end
  context "contentの文字数が100文字以内の場合" do
    it "有効な状態であること" do
      user = build(:user, content: "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890")
      expect(user).to be_valid
    end
  end

  it "passwordがなれけば無効な状態であること" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "passwordとpassword_confirmationが違う場合は無効な状態であること" do
    user = build(:user, password_confirmation: "password1")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end

  it"重複したemailなら無効な状態であること" do
    create(:user, email: "aaa@example.com")
    user = build(:user, email: "aaa@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end
