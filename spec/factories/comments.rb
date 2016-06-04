FactoryGirl.define {
  factory(:comment) {
    body RandomData.random_paragraph
    post
    user
  }
}
