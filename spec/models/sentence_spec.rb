require 'rails_helper'

RSpec.describe Sentence do
  describe "Validations" do
    it "must contain at least 3 words" do
      sentence = Sentence.new(text: "Hello")
      expect(sentence).to be_invalid
    end
    it "must end with a full stop, exclamation mark or question mark" do
      sentence = Sentence.new(text: "This needs a full stop")
      expect(sentence).to be_invalid
      expect(Sentence.new(text: "This needs a full stop.")).to be_valid
      expect(Sentence.new(text: "Or an exclamation mark!")).to be_valid
      expect(Sentence.new(text: "Or a question mark?")).to be_valid
    end
    it "cannot contain a url" do
      sentence = Sentence.new(text: 'Then he bought some viagra from cheapviagra.com and was very happy.')
      expect(sentence).to be_invalid
      sentence = Sentence.new(text: "Can I include <a href='/naughty/boy'>links</a>")
      expect(sentence).to be_invalid
    end
    it "cannot contain more than one sentence" do
      sentence = Sentence.new(text: "This has a sentence following it. That is naughty.")
      expect(sentence).to be_invalid
      sentence = Sentence.new(text: "What about question marks? That is naughty too.")
      expect(sentence).to be_invalid
      sentence = Sentence.new(text: "Surely this is invalid! I hope so")
      expect(sentence).to be_invalid
    end
    it "must be unique within the scope of the parent" do
      sentence1 = Sentence.create(text: 'This is the first sentence.', parent_id: nil)
      sentence2 = Sentence.create(text: 'This is the second sentence.', parent_id: sentence1.id)
      sentence3 = Sentence.new(text: 'This is the second sentence.', parent_id: sentence1.id)
      expect(sentence3).to be_invalid
    end
  end

  describe "story" do
    it "returns the parents of the sentence in correct order" do
      sentence1 = Sentence.create(text: 'This is the first sentence.', parent_id: nil)
      sentence2 = Sentence.create(text: 'This is the second sentence.', parent_id: sentence1.id)
      sentence3 = Sentence.create(text: 'This is the third sentence.', parent_id: sentence2.id)
      expect(sentence3.story).to eq "This is the first sentence. This is the second sentence. This is the third sentence."
    end
  end
end