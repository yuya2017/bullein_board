class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :messages
  belongs_to :post

  validate :name_validate

  private

  def name_validate
    if name.blank?
      errors.add(:name, "を入力してください.")
    elsif name.length > 12
      errors.add(:name, "12文字以内にしてください。")
    end
  end

end
