FactoryGirl.define {
  factory(:topic) {
    name RandomData.random_name
    description RandomData.random_sentence
  }
}
