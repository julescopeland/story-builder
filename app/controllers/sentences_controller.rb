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