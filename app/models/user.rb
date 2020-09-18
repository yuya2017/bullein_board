class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_rooms
  has_many :rooms, through: :user_rooms

  validate :username_presence
  validate :chess_presence
  validate :app_presence
  validate :time_presence

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
    user.confirmed_at = Time.now
    end
  end


  private

  def username_presence
    unless encrypted_password_changed?
      if username.blank?
        errors.add(:base, " ユーザー名を入力してください.")
      elsif username.length > 10
        errors.add(:base, "ユーザー名は10文字以内にしてください。")
      end
    end
  end

  def chess_presence
    unless encrypted_password_changed?
      if chess.blank?
        errors.add(:base, "棋力を入力してください.")
      elsif chess.length > 10
        errors.add(:base, "棋力は10文字以内にしてください。")
      end
    end
  end

  def app_presence
    unless encrypted_password_changed?
      if app.blank?
        errors.add(:base, "アプリ名を入力してください.")
      elsif app.length > 30
        errors.add(:base, "アプリ名は30文字以内にしてください。")
      end
    end
  end

  def time_presence
    unless encrypted_password_changed?
      if time.blank?
        errors.add(:base, "持ち時間を入力してください.")
      elsif time.length > 10
        errors.add(:base, "持ち時間は12文字以内にしてください。")
      end
    end
  end

end
