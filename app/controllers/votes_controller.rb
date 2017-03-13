class VotesController < ApplicationController

  def create
    if vote_values.length == 3
      Vote.create(vote_params.values)
    end
    redirect_to root_path
  end

  private
  def vote_params
    params.require(:votes).permit!
  end

  def vote_values
    vote_params.values.map {|v| v[:value]}.reject(&:empty?).uniq
  end
end
