module Api
  class StatsController < ApplicationController

    def index
      render json: characters
    end

    private

    def characters
      chars = Character.all
      votes = Vote.all
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

    def votes_by_character
      @votes_by_character ||= @votes.inject({}) do |memo, vote|
        if memo[vote.character_id]
          memo[vote.character_id].push(vote)
        else
          memo[vote.character_id] = [vote]
        end
        memo
      end
    end

    def characters_with_stats
      @characters.map do |character|
        votes = votes_by_character[character.id]
        values = Vote.values.keys.to_a.map do |val|
          {
            name: val,
            votes: votes ? votes.select {|vote| vote.value == val} : []
          }
        end
        {
          name: character.name,
          stats: values
        }
      end
    end
  end
end
