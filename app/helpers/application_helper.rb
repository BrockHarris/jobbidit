module ApplicationHelper

  def render_profile_pic(user, size=:size, opts={})
    if user.photo.exists?
      return image_tag user.photo.url(size)
    else
      image_tag "genericpic-#{size}.png" 
    end
  end
end
