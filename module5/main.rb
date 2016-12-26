require_relative 'modules/instance_counter'
require_relative 'modules/manufacturer'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagoon'
require_relative 'passenger_wagoon'
require_relative 'cargo_wagoon'
require_relative 'passenger_train'
require_relative 'cargo_train'

class Main
  attr_accessor :stations, :trains, :wagoons, :route, :routes, :current_station
  attr_reader :current_train

  def initialize
    @stations = []
    @trains = []
    @wagoons = []
    @route = ''
    @routes = []
    @current_train = ''
    @current_station = ""
  end

  def run
    loop do
      puts
      puts "__________________MENU__________________"
      puts "Нажмите на букву: \'q\' - чтобы выйти из приложения."
      puts
      puts "I. Секция: Создать."
      puts "Введите в консоль:"
      puts "1 - чтобы создать станцию."
      puts "2 - чтобы создать поезд."
      puts "3 - чтобы создать маршрут (начальные и конечные станции маршрута)."
      puts
      puts "II. Секция. Показать списки."
      puts "Введите в консоль:"
      puts "4 - показть станции."
      puts "5 - показать поезда."
      puts "6 - показть поезда на станциях."
      puts "7 - показать маршруты (с начальными и конечными станциями)."
      puts
      puts "III. Секция. Нахождения поездов и манипуляции ими."
      puts "Введите в консоль:"
      puts "8 - распложить на станции, чтобы начать маршрут."
      puts "9 - прицепить вагон."
      puts "10 - отцепить вагон."
      # puts "11 - показать следующую станцию на маршруте."
      # puts "12 - показать предыдущую станцию на маршруте."
      # puts "13 - удалить станцию из маршрута."
      puts
      puts "IV. Секция. О информация о производителе поездов."
      puts "Введите в консоль:"
      puts "11 - присвоить имя производителя к поездам."
      puts "12 - найти инстанс поезд."
      puts "13 - все инстанс станции."
      puts "14 - чтобы получить информацию о производителе."
      puts

      user_input = STDIN.gets.encode('UTF-8').chomp
      puts

      case user_input
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route
      when '4'
        print_stations
      when '5'
        print_trains
      when '6'
        print_trains_at_station
      when '7'
        print_routes
      when '8'
        locate_train
      when '9'
        add_wagoon
      when '10'
        delete_wagoon
      when '11'
        set_manufacturer
      when '12'
        find_instance_train
      when '13'
        show_all_instance_stations
      when '14'
        show_manufacturer
      when 'q'
        break puts "Вы вышли из приложения!"
      else
        puts "Попытайтесь еще раз!"
      end
    end
  end

# ниже следуют приватные методы, они приватны, так, как не будут вызываться в других файлах приложения.
# поэтому должны быть скрытыми
private
  # section I
  def create_station
    puts "Создайте станцию."
    puts "Введите название:"
    station_name = STDIN.gets.encode('UTF-8').chomp
    if @stations.push Station.new(station_name)
      puts "Станция создана!"
      return station_name
    else
      puts "Станция не создана!"
    end
  end

  def create_train
    puts "Создайте поезд."
    puts "Введите номер, только цифры:"
    number = STDIN.gets.encode('UTF-8').to_i
    puts "Введите тип поезда."
    puts "Надо ввести индекс типа:"
    puts "1 - cargo"
    puts "2 - passenger"

    user_input = STDIN.gets.encode('UTF-8').to_i

    if user_input == 1
      type = 'cargo'
      @trains.push Cargo.new(number, type)
      puts "Поезд типа cargo создана!"
    elsif user_input == 2
      type = 'passenger'
      @trains.push Passenger.new(number, type)
      puts "Поезд типа passenger созадана!"
    else
      puts "Поезд не создан!"
    end
  end

  def create_route
    if @stations.count > 1
      puts "Создайте маршрут. Выберите станцию для начальной точки отправки поезда:"
      index = 0
      @stations.each do |station|
        index +=1
        puts "Индекс станции: #{index} - название станции: #{station.station_name}"
        puts "Не достаточно станции для создания маршрута!" if @stations.count == 1
      end
      puts "Введите индекс станции:"
      start_index = STDIN.gets.encode('UTF-8').to_i

      puts "Создайте маршрут. Выберите станцию для конечной точки прибытия:"
      index = 0
      @stations.each do |station|
        index +=1
        puts "Индекс станции: #{index} - название станции: #{station.station_name}"
      end
      puts "Введите индекс следующей станции:"
      end_index = STDIN.gets.encode('UTF-8').to_i

      start_point = @stations[start_index-1]
      end_point = @stations[end_index-1]

      @route = Route.new(start_point, end_point)
      puts "Создан маршрут:: начало станция - #{@route.stations[0].station_name} : конечная станция - #{@route.stations[1].station_name}."
      @route.show_all_route_stations
      @routes.push(@route)
    else
      puts "Вы должны создать станции, чтобы добавить в маршрут! Чтобы у маршрута было начальная и конечная станция." if @stations.count == 1
    end
  end

  # section II
  def print_stations
    if @stations.empty?
      puts "Нет ни одной станции!"
    else
      puts "Список станций:"
      @stations.each { |station| puts station.station_name }
    end
  end

  def print_trains
    if @trains.empty?
      puts "Нет ни одного поезда!"
    else
      puts "Список поездов:"
      @trains.each { |train| puts "Номер поезда: #{train.number} - тип: #{train.type} - производитель:#{train.company_name}" }
    end
  end

  def print_trains_at_station
    if @stations.count > 0
      puts "Выберите станцию, чтобы увидеть находящиеся в нем поезда:"
      index = 0
      @stations.each do |station|
        index += 1
        puts "Индекс станции: #{index} - название: #{station.station_name}"
      end

      puts "Введите индекс станции:"
      station_index = STDIN.gets.encode('UTF-8').to_i

      @stations[station_index-1].show_all_trains
    end
  end

  def print_routes
    if @routes.empty?
      puts "Нет ни одного маршрута!"
    else
      @routes.each { |route| route.show_all_route_stations}
    end
  end

  # section III
  def locate_train
    if @trains.count > 0
      index = 0
      @trains.each do |train|
        index +=1
        puts "Индекс поезда: #{index} - Номер поезда: #{train.number} - Тип поезда: #{train.type}"
      end

      puts "Введите индекс:"
      index_number = STDIN.gets.encode('UTF-8').to_i

      if index_number <= @trains.count
        if @stations.count > 0
          puts "Введите индекс станции, чтобы разместить в нем текущий поезд, которого выбрали."
          index = 0
          @stations.each do |station|
            index +=1
            puts "Индекс станции: #{index} - название станции: #{station.station_name}"
          end
          index_station = STDIN.gets.encode('UTF-8').to_i
          if index_station <= @stations.count
            @stations[index_station-1].arrive_train(@trains[index_number-1])
          end
        end
      end
    else
      puts "Нет ни одного поезда!"
    end
  end

  def add_wagoon
    puts "Какому поезду вы бы хотели прицепить вагон?"
    if @trains.count > 0
      index = 0
      @trains.each do |train|
        index +=1
        puts "Поезд с номером: #{train.number} - тип поезда: #{train.type}"
      end
    end

    puts "Введите номер поезда, только цифры:"
    number = STDIN.gets.encode('UTF-8').to_i

    puts "Введите тип поезда:"
    puts "1 - cargo"
    puts "2 - passenger"
    user_input = STDIN.gets.encode('UTF-8').to_i

    @current_train = @trains.find { |train| train.number == number }
    if user_input == 1
      wagoon = Cargo_wagoon.new
    elsif user_input == 2
      wagoon = Passenger_wagoon.new
    end
    @current_train.hook_wagoons(wagoon)
  end

  def delete_wagoon
    puts "Введите номер поезда, только цифры:"
    print_trains
    number = STDIN.gets.encode('UTF-8').to_i
    @current_train = @trains.find { |train| train.number == number }
    @current_train.detach_wagoons
  end

  def set_manufacturer
    if @trains.size.zero?
      puts "Нет ни одного поезда!"
    elsif @trains.count > 0
      puts "Какому поезду вы бы хотели присвоить имя производителя?"
      index = 0
      @trains.each do |train|
        index +=1
        puts "Поезд с номером: #{train.number} - тип поезда: #{train.type}"
      end
    end

    puts "Введите номер поезда, только цифры:"
    number = STDIN.gets.encode('UTF-8').to_i

    train = @trains.find { |train| train.number == number }

    puts "Введите название производителя:"
    user_input = STDIN.gets.encode('UTF-8').chomp

    train.company_name = user_input
    show_manufacturer
  end

  def show_manufacturer
    puts "Название производителя:"
    @trains.each do |train|
      puts "Номер поезда:#{train.number} - тип поезда:#{train.type} - производитель: #{train.company_name}"
    end
  end

  def find_instance_train
    if @trains.count > 0
      puts "Какой поезд вы бы хотели найти?"
      index = 0
      @trains.each do |train|
        index +=1
        puts "Поезд с номером: #{train.number} - тип поезда: #{train.type}"
      end
    end

    puts "Введите номер поезда, только цифры:"
    number = STDIN.gets.encode('UTF-8').to_i
    train = @trains.find { |train| train.number == number }

    Train.find(train)

  end

  def show_all_instance_stations
    if @stations.size.zero?
      puts "Нет ни одного объекта станции!"
    else
      puts "Все объекты станции, которые созданны на данный момент."
      puts Station.all
    end
  end

end
