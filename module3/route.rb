# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута,
# а промежуточные могут добавляться между ними.

# Может добавлять промежуточную станцию в список

# Может удалять промежуточную станцию из списка

# Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_accessor :stations

  def initialize(start_point, end_point)
    @stations = [start_point, end_point]
  end

  def add_station(transitional_point)
    @stations.insert(-2, transitional_point)
    puts "New station #{transitional_point.station_name} was added!"
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
    puts 'All stations on the routes: '
    @stations.each { |station| puts station.station_name }
  end
end
