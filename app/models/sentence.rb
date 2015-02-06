class Sentence < ActiveRecord::Base
  validate :text, :must_have_at_least_3_words, :must_end_with_correct_punctuation, :must_not_contain_more_than_one_sentence
  validates :text, uniqueness: {scope: :parent_id}
  # validates :text, format: {with: /(\w+\s){2,}\w+[.?!]/, message: "must contain at least three words and end with a full-stop(.), exclamation mark(!) or question mark(?)"}

  scope :opening_lines, ->{ where(parent_id: nil) }

  has_many :next_lines, class_name: Sentence, foreign_key: 'parent_id'
  belongs_to :parent, class_name: Sentence

  def story
    return text unless parent
    [parent.story, text].join(" ")
  end

  private

  def must_have_at_least_3_words
    if text.split(/\s+/).count < 3
      errors.add(:text, "must contain at least three words")
    end
  end

  def must_end_with_correct_punctuation
    unless text[-1] =~ /[.!?]/
      errors.add(:text, "must end with either '.', '!' or '?'")
    end
  end

  def must_not_contain_more_than_one_sentence
    if text.split(/[.!?]/).count > 1
      errors.add(:text, "can not contain more than one sentence")
    end
  end
end
