require 'rails_helper'

RSpec.describe OpeningLineControls do
  describe "html" do
    it "includes the delete button for admins" do
      user = instance_double(User, admin?: true)
      sentence = instance_double(Sentence, id: 1)
      html = OpeningLineControls.html(sentence, user)
      expect(html).to include("data-method=\"delete\"")
      expect(html).to include("class=\"btn btn-danger\"")
    end
  end
end