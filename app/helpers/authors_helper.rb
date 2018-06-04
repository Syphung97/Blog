module AuthorsHelper
  def gravatar_for(author, size: 50)
    gravatar_id = Digest::MD5::hexdigest(author.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: author.name, class: "gravatar")
  end
end
