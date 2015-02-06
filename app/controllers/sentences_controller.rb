class SentencesController < ApplicationController

  def new_opening_line
    @opening_line = Sentence.new
  end

  def create_opening_line
    @opening_line = Sentence.create(sentence_params)
    if @opening_line.persisted?
      redirect_to root_path
    else
      render :new_opening_line
    end
  end

  def show
    @sentence = Sentence.find(params[:id])
    @new_sentence = Sentence.new
  end

  def create
    text = sentence_params[:text].sub(/./){$&.upcase}
    @sentence = Sentence.create(parent_id: params[:sentence_id], text: text)
    if @sentence.persisted?
      render json: @sentence, status: 200
    else
      render json: @sentence.errors.full_messages.join("</li><li>").html_safe, status: :unprocessable_entity
    end
  end

  def destroy
    @sentence = Sentence.find(params[:id])
    @sentence.destroy!
    redirect_to root_path, notice: "Sentence deleted"
  end

  private

  def sentence_params
    params.require(:sentence).permit([:text])
  end
end