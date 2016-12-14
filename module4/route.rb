class Route
  attr_accessor :stations

  def initialize(start_point, end_point)
    @stations = [start_point, end_point]
  end

  def add_station(transitional_point)
    @stations.insert(-2, transitional_point)
    puts "New station was added to route!"
  end

  def destroy_station(deleting_station)
    if @stations.include? deleting_station
      puts "The station #{deleting_station.station_name} is deleting from route."
      @stations.delete(deleting_station)
    else
      puts "The station #{deleting_station.station_name} is not found!"
    end
  end

  def show_all_route_stations
    puts "All stations on the routes: "
    @stations.each { |station| puts station.station_name }
  end
end
