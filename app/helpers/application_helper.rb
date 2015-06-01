module ApplicationHelper
  def errors_for(resource)
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }

    #has_one_assoc = resource.reflect_on_all_associations(:has_one).map(&:name)
    #has_many_assocs = resource.reflect_on_all_associations(:has_many).map(&:name)
#
    #has_one_assoc.each do |assoc|
    #  messages << resource.send(assoc).errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    #end
#
    #has_many_assocs.each do |assoc|
    #  resource.send(assoc).each do |model|
    #    messages << model.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    #  end
    #end

    messages = messages.join

    html = <<-HTML
    <div class="alert alert-danger alert-block"> <button type="button"
    class="close" data-dismiss="alert">x</button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def active?(path)
    'active' if current_page?(path)
  end
end
