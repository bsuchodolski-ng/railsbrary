module DeviseHelper
  def devise_error_messages!
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div id="error_explanation" class="has-text-danger">
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
