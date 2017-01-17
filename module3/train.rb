# Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
# эти данные указываются при создании экземпляра класса

# Может набирать скорость
# Может показывать текущую скорость
# Может тормозить (сбрасывать скорость до нуля)

# Может показывать количество вагонов
# Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
# метод просто увеличивает или уменьшает количество вагонов).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.

# Может принимать маршрут следования (объект класса Route)
# Может перемещаться между станциями, указанными в маршруте.
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_accessor :number, :type, :wagoons, :speed, :current_speed, :current_station, :route

  def initialize(number, type, wagoons)
    @number = number
    @type = type
    @wagoons = wagoons
    @speed = 0.0
    @current_station = 0
  end

  def stop
    @speed = 0
    puts "Train #{@number} has been stopped."
  end

  def speed_up(speed)
    @speed += speed
  end

  def current_speed
    puts "Train by number: #{@number} has speed: #{@speed} - km/hours."
  end

  def wagoons_count
    puts "Train by number: #{@number}, type: #{@type}, has #{@wagoons} wagoons."
  end

  def hook_wagoons
    @wagoons += 1 if @speed == 0
    puts "Train #{@number} has #{@wagoons} wagoons."
  end

  def detach_wagoons
    @wagoons -= 1 if @speed == 0 && @wagoons > 0
    puts "Train #{@number} has detaching wagoon, now has #{@wagoons} wagoons."
  end

  def get_route(route)
    @route = route
    puts "Train #{number} has route: #{@route.stations[0].station_name} - #{@route.stations[1].station_name}."
  end

  def move_next_route
    puts "Train #{number} move to next station: #{@route.stations[@current_station].station_name}" if @current_station += 1
  end

  def move_previous_route
    puts "Train #{number} move to previous station: #{@route.stations[@current_station].station_name}" if @current_station -= 1
  end

  def current_station
    puts "The current station: #{@route.stations[@current_station].station_name}" unless @route.nil?
  end

  def next_station
    next_station = @current_station + 1
    puts "The next station: #{@route.stations[next_station].station_name}"
  end

  def previous_station
    previous_station = @current_station - 1
    puts "The previous station: #{@route.stations[previous_station].station_name}"
  end
end
