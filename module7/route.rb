class Route
  attr_accessor :stations, :route_number

  def initialize(start_point, end_point)
    @route_number = rand(1..999)
    validate!
    @stations = [start_point, end_point]
  end

  def add_station(transitional_point)
    @stations.insert(-2, transitional_point)
  end

  def destroy_station(deleting_station)
    if @stations.include? deleting_station
      @stations.delete(deleting_station)
    end
  end

  def show_all_route_stations
    @stations.each { |station| puts station.station_name }
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise "Номер маршрута не может быть больше трех знаков!" if @route_number > 999
  end
end
