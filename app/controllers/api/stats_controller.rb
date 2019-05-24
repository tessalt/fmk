module Api
  class StatsController < ApplicationController

    def index
      render json: characters
    end

    private

    def characters
      sql = "select c.name, c.photo, count(v.id), v.value, v.character_id from votes v join characters c on v.character_id=c.id group by v.value, v.character_id, c.name, c.photo"
      records_array = ActiveRecord::Base.connection.execute(sql)

      characters = records_array.group_by {|r| r["character_id"]}

      characters.map do |character, rows|
        {
          name: rows[0]["name"],
          photo: rows[0]["photo"],
          votes: rows.map do |row|
            {
              value: Vote.values.key(row["value"]),
              count: row["count"]
            }
          end
        }
      end
    end
  end
end
