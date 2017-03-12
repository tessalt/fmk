class GameController < ApplicationController

  def index
    @votes = []
    3.times do
      @votes << Vote.new
    end
    @characters = Character.order("RANDOM()").limit(3)
  end
end
