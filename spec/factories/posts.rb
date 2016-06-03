FactoryGirl.define {
  factory(:post) {
    title RandomData.random_sentence
    body RandomData.random_paragraph
    topic
    user
    rank 0.0
  }
}
