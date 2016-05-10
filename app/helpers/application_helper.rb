module ApplicationHelper
  def form_group_tag errors, &block
    css_class = 'form-group'
    if errors.any?
      css_class << ' has-error'
    end
    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url user
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
  end
end
