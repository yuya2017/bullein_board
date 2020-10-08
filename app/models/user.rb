class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validate :username_validate
  validate :chess_validate
  validate :app_validate
  validate :time_validate
  validate :content_validate

  def remember_me
    true
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "ゲスト"
      user.app = "何でも可"
      user.time = "何でも可"
      user.chess = "30級"
      user.content = "ゲストユーザーです。"
      user.confirmed_at = Time.now
    end
  end


  private

  def username_validate
    if username.blank?
      errors.add(:username, "を入力してください")
    elsif username.length > 10
      errors.add(:username, "は10文字以内にしてください")
    end
  end

  def chess_validate
    if chess.blank?
      errors.add(:chess, "を入力してください")
    elsif chess.length > 10
      errors.add(:chess, "は10文字以内にしてください")
    end
  end

  def app_validate
    if app.blank?
      errors.add(:app, "を入力してください")
    elsif app.length > 30
      errors.add(:app, "は30文字以内にしてください")
    end
  end

  def time_validate
    if time.blank?
      errors.add(:time, "を入力してください")
    elsif time.length > 10
      errors.add(:time, "は10文字以内にしてください")
    end
  end

  def content_validate
    if content.length > 100
      errors.add(:content, "は100文字以内にしてください")
    end
  end

end
