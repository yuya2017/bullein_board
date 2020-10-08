user = User.new(
  email: "tester@example.com",
  password: "hogehoge",
  admin: true,
  confirmed_at: Time.now
)
user.save!(validate: false)
