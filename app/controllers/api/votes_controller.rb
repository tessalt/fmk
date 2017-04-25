module Api
  class VotesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def create
      if vote_values.length == 3
        Vote.create(vote_params[:votes])
        render json: characters
      end
    end

    private
    def vote_params
      params.permit(votes: [:value, :character_id])
    end

    def vote_values
      vote_params[:votes].map {|v| v[:value]}.reject(&:empty?).uniq
    end

    def character_ids
      vote_params[:votes].map{|v| v[:character_id]}.sort
    end

    def characters
      chars = Character.find(character_ids)
      votes = Vote.where(character_id: character_ids)
      chars.map do |char|
        character_votes = votes.select {|v| v[:character_id] == char[:id]}
        results = Vote.values.keys.to_a.map do |val|
          {
            value: val,
            count: character_votes ? character_votes.select {|vote| vote.value == val}.length : 0
          }
        end
        char.as_json.merge({votes: results})
      end
    end
  end
end
