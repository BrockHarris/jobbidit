module ApplicationHelper

  def render_profile_pic(user, size=:size, opts={})
    if user.photo.exists?
      return image_tag user.photo.url(size)
    else
      image_tag "genericpic-#{size}.png" 
    end
  end

  def user_messages(current_user)
    if current_user
      @messages = Pmessage.order.find_all_by_receiver_id(current_user.id)
      return @messages
    end
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, ("add_fields(this, '#{association}', '#{escape_javascript(fields)}')"))
  end
end
