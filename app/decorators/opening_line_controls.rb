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
        read: {text: "Read this story", path: Rails.application.routes.url_helpers.new_sentence_story_path(opening_line), style: 'info'},
        write: {text: "Write the next line", path: Rails.application.routes.url_helpers.new_sentence_path(opening_line), style: 'success'},
        delete: {text: "Delete", path: Rails.application.routes.url_helpers.sentence_path(opening_line), style: 'danger', method: :delete}
      }
      if user && user.admin?
        options.slice(:read, :write, :delete)
      else
        options.slice(:read, :write)
      end
    end
  end
end