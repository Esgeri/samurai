class Train	
  attr_accessor :number, :type, :wagoons, :speed, :current_station, :route

  def initialize(number, type)
    @number = number
    @type = type
    @wagoons = []
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
    puts "Train: #{@number} has speed: #{@speed} - km/hours."
  end

  def wagoons_count
    puts "Train: #{@number}, type: #{@type}, has #{@wagoons.count} wagoons."
  end

  def hook_wagoons(wagoon)
    if @speed == 0
      @wagoons << wagoon
      puts "Train #{@number} has #{@wagoons.count} wagoons by type: #{wagoon.type}."
    end
  end

  def detach_wagoons
    @wagoons.pop if @speed == 0 && !@wagoons.empty?
    puts "Train #{@number} has detaching wagoon, now has #{@wagoons.size} wagoons."
  end

  def get_route(route)
    @route = route
    puts "Train #{self.number} has route: #{@route.stations[0].station_name} - #{@route.stations[1].station_name}."
  end

  def move_next_route
    puts "Train #{self.number} move to next station: #{@route.stations[@current_station].station_name}" if @current_station += 1
  end

  def move_previous_route
    puts "Train #{self.number} move to previous station: #{@route.stations[@current_station].station_name}" if @current_station -= 1
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
