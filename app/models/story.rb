class Story < ActiveRecord::Base
  def sentence_texts
    Sentence.find(sentences).map(&:text)
  end
end
