class OpeningLineControls
  class << self
    include ActionView::Helpers::UrlHelper

    def html(opening_line, user)
      buttons(opening_line, user).map do |name, button|
        link_to button[:text],button[:path], method: button[:method], class: "btn btn-#{button[:style]}"
      end.join(' ').html_safe
    end

    private
    def buttons(opening_line, user)
      options = {
        continue: {text: "Continue this story", path: Rails.application.routes.url_helpers.sentence_path(opening_line), style: 'info'},
        delete: {text: "Delete", path: Rails.application.routes.url_helpers.sentence_path(opening_line), style: 'danger', method: :delete}
      }
      if user && user.admin?
        options.slice(:continue, :delete)
      else
        options.slice(:continue)
      end
    end
  end
end