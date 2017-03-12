class ResultsController < ApplicationController
  def index
    @votes = Vote.all
    @characters = Character.all
    @characters_with_stats = characters_with_stats
  end

  private

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
