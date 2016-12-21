class Route
  attr_accessor :stations

  def initialize(start_point, end_point)
    @stations = [start_point, end_point]
  end

  def add_station(transitional_point)
    @stations.insert(-2, transitional_point)
    puts "Промежуточная станция была добавлена на маршрут!"
  end

  def destroy_station(deleting_station)
    if @stations.include? deleting_station
      puts "Станция: #{deleting_station.station_name} убран с маршрута."
      @stations.delete(deleting_station)
    else
      puts "Станция: #{deleting_station.station_name} не найдена! Она вне этого маршрута!"
    end
  end

  def show_all_route_stations
    puts "Все станции маршрута:"
    @stations.each { |station| puts station.station_name }
  end
end
