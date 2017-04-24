module Api
  class CharactersController < ApplicationController

    def index
      @characters = Character.order("RANDOM()").limit(3).sort_by {|c| c.id}
      render json: @characters
    end
  end
end
