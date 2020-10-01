class Post < ApplicationRecord
  belongs_to :user
  has_one :room
  accepts_nested_attributes_for :room

  validates :user_id, presence: true
  validate :chess_validate
  validate :app_validate
  validate :time_validate
  validate :all_tag_validate
  validate :content_validate

  private


  def chess_validate
    if chess.blank?
      errors.add(:chess, "を入力してください")
    elsif chess.length > 10
      errors.add(:chess, "は10文字以内にしてください")
    end
  end
  def app_validate
    if app.blank?
      errors.add(:app, "を入力してください.")
    elsif app.length > 30
      errors.add(:app, "は30文字以内にしてください")
    end
  end
  def time_validate
    if time.blank?
      errors.add(:time, "を入力してください.")
    elsif time.length > 10
      errors.add(:time, "は10文字以内にしてください")
    end
  end
  def all_tag_validate
    if all_tag.length > 20
      errors.add(:all_tag, "は合計20文字以内にしてください")
    end
  end
  def content_validate
    if content.length > 100
      errors.add(:content, "は100文字以内にしてください")
    end
  end
end
