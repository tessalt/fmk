class VotesController < ApplicationController

  def create
    if Vote.create(vote_params.values)
      redirect_to root_path
    else

    end
  end

  private
  def vote_params
    params.require(:votes).permit!
  end
end
