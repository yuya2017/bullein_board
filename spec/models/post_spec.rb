require 'rails_helper'

RSpec.describe Post, type: :model do
  it "chess, app, timeがあれば有効な状態であること" do
    post = build(:post)
    expect(post).to be_valid
  end
end
