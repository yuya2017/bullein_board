class Post < ApplicationRecord
  belongs_to :user
  has_one :room
  accepts_nested_attributes_for :room

  validates :user_id, presence: true
  validate :roomname_presence
  validate :chess_presence
  validate :app_presence
  validate :time_presence
  validate :all_tag_presence
  validate :content_presence

  private


  def roomname_presence
    if room.name.blank?
      errors.add(:base, "部屋の名前を入力してください.")
    elsif room.name.length > 12
      errors.add(:base, "部屋の名前12文字以内にしてください。")
    end
  end
  def chess_presence
    if chess.blank?
      errors.add(:base, "棋力を入力してください.")
    elsif chess.length > 10
      errors.add(:base, "棋力は10文字以内にしてください。")
    end
  end
  def app_presence
    if app.blank?
      errors.add(:base, "アプリ名を入力してください.")
    elsif app.length > 30
      errors.add(:base, "アプリ名は30文字以内にしてください。")
    end
  end
  def time_presence
    if time.blank?
      errors.add(:base, "持ち時間を入力してください.")
    elsif time.length > 10
      errors.add(:base, "持ち時間は12文字以内にしてください。")
    end
  end
  def all_tag_presence
    if all_tag.length > 20
      errors.add(:base, "タグは合計20文字以内にしてください。")
    end
  end
  def content_presence
    if content.length > 100
      errors.add(:base, "募集内容は100文字以内にしてください。")
    end
  end
end
