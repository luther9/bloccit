FactoryGirl.define {
  pw = RandomData.random_sentence
  factory(:user) {
    name RandomData.random_name
    sequence(:email) { |n|
      "user#{n}@factory.com"
    }
    password pw
    password_confirmation pw
    role :member
  }
}
