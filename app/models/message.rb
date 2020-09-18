class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
