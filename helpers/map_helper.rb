module MapHelper
  def city_marker(city, info_window: true)
    {
      lat: city.lat,
      lng: city.lng,
      picture: { url: asset_path(:images, "marker.svg"), width: 32, height: 32 }
    }.tap { |marker| marker[:infowindow] = partial("partials/map/info_window", locals: { city: city }) if info_window }
  end

  def map_all_city_markers
    data.cities.map { |city| city_marker(city) }
  end

  def map_competition_markers(competition)
    tracks_cities = competition.tracks.flat_map { |t| [city(t.start_city_id), city(t.end_city_id)] }

    route_cities = [city(competition.start_city_id), city(competition.end_city_id), tracks_cities].flatten.uniq(&:name)

    route_cities.map { |city| city_marker(city, info_window: false) }
  end

  def map_competition(competition)
    {
      id: competition.id,
      name: competition.name,
      start_city: {
        lat: city(competition.start_city_id).lat,
        lng: city(competition.start_city_id).lng,
        name: city(competition.start_city_id).name
      },
      end_city: {
        lat: city(competition.end_city_id).lat,
        lng: city(competition.end_city_id).lng,
        name: city(competition.end_city_id).name
      },
      tracks: competition.tracks.map do |track|
        {
          end_city: {
            name: city(track.end_city_id).name
          }
        }
      end
    }
  end

  def map_all_competitions
    data.competitions.map { |competition| map_competition(competition) }
  end
end
