class Train
  attr_accessor :number, :type, :wagoons, :speed, :current_station, :route

  def initialize(number, type)
    @number = number
    @type = type
    @wagoons = []
    @speed = 0.0
    @current_station = 0
  end

  def stopped!
    @speed = 0
    puts "Поезд с номером: #{@number} остановлен. Стоит."
  end

  def speed_up(speed)
    @speed += speed
  end

  def current_speed
    puts "Поезд с номером: #{@number} имеет скорость: #{@speed} - км/час."
  end

  def wagoons_count
    puts "Поезд с номером: #{@number}, тип: #{@type}, имеет: #{@wagoons.count} вагона."
  end

  def hook_wagoons(wagoon)
    if @speed == 0 && wagoon.type == self.type
      puts "Сотрудники станции железно-дорожного вокзала проверяют подходят ли тип поезда и тип вагона."
      puts "Осмотр поезда: #{self.type} - верно!"
      sleep 1
      puts "Осмотр типа вагона: #{wagoon.type} - верно!"
      @wagoons << wagoon
      puts "Поез с номером: #{@number} и типа: #{self.type} имеет #{@wagoons.count} вагона с типом: #{wagoon.type}."
    else
      puts "Тип вагона не соответствует типу поезда. Вагон не прицеплен! "
    end
  end

  def detach_wagoons
    @wagoons.pop if @speed == 0 && !@wagoons.empty?
    puts "Поезд с номером: #{@number} отцепил вагон, теперь имеет: #{@wagoons.size} вагона."
  end

  def get_route(route)
    @route = route
    puts "Поезд с номером: #{self.number} имеет маршрут:"
    puts "начальная станция: #{@route.stations[0].station_name} - конечная станция: #{@route.stations[1].station_name}."
  end

  def move_next_route
    puts "Поезд с номером: #{self.number} движется на следующую станцию: #{@route.stations[@current_station].station_name}" if @current_station += 1
  end

  def move_previous_route
    puts "Поезд с номером: #{self.number} движется на предыдущую станцию: #{@route.stations[@current_station].station_name}" if @current_station -= 1
  end

  def current_station
    puts "Текущая станция: Место нахождения поезда, станция: #{@route.stations[@current_station].station_name}" unless @route.nil?
  end

  def next_station
    next_station = @current_station + 1
    puts "Следующая станция прибытия: #{@route.stations[next_station].station_name}"
  end

  def previous_station
    previous_station = @current_station - 1
    puts "Предыдущая станция. Откуда отбыло. Станция: #{@route.stations[previous_station].station_name}"
  end
end
