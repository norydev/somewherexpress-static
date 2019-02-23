module DomainHelper
  def competition_victories(user)
    data.competitions.select do |competition|
      rank = competition.ranks.find { |rank| rank.user_id == user.id }
      rank && rank.result == 1
    end
  end

  def track_victories(user)
    data.competitions.flat_map do |competition|
      competition.tracks.select do |track|
        rank = track.ranks.find { |rank| rank.user_id == user.id }
        rank && rank.result == 1
      end
    end
  end

  def track_name(track)
    "#{city(track.start_city_id).locality} (#{city(track.start_city_id).country_short}) – #{city(track.end_city_id).locality} (#{city(track.end_city_id).country_short})"
  end

  def route(competition)
    rte = "#{city(competition.start_city_id).locality} (#{city(competition.start_city_id).country_short}) – "
    competition.tracks.each do |t|
      next if city(t.end_city_id).locality == city(competition.end_city_id).locality

      rte += "#{city(t.end_city_id).locality} (#{city(t.end_city_id).country_short}) – "
    end
    rte += "#{city(competition.end_city_id).locality} (#{city(competition.end_city_id).country_short})"
  end

  def competition_boundaries(competition)
    "#{city(competition.start_city_id).locality} (#{city(competition.start_city_id).country_short}) – #{city(competition.end_city_id).locality} (#{city(competition.end_city_id).country_short})"
  end

  def participants(competition)
    competition.ranks.map { |rank| user(rank.user_id) }
  end

  def city(id)
    data.cities.find { |city| city.id == id }
  end

  def user(id)
    data.users.find { |user| user.id == id }
  end

  def competition(id)
    data.competitions.find { |competition| competition.id == id }
  end
end
