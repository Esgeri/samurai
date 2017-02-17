class Route
  include Validation

  attr_accessor :stations, :count, :route_number

  def initialize(start_point, end_point)
    @route_number = rand(1..999)
    # validate!
    @stations = [start_point, end_point]
    @count = 1
  end

  def show_route_number
    @route_number
  end

  def add_station(transitional_point)
    @stations.insert(-2, transitional_point)
    @count += 1
  end

  def destroy_station(deleting_station)
    @stations.delete(deleting_station) if @stations.include? deleting_station
    @count -= 1
  end

  def show_all_route_stations
    @stations.each { |station| puts station.station_name }
  end

  def routes_count
    @count
  end
end
