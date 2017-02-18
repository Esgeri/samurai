require_relative 'modules/instance_counter'
require_relative 'modules/manufacturer'
require_relative 'modules/validation'
require_relative 'modules/accessor'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'wagoon'
require_relative 'passenger_wagoon'
require_relative 'cargo_wagoon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'test'

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
    @current_station = ''
    @wagoons_base = {}
  end

  def run
    loop do
      puts
      puts '__________________MENU__________________'
      puts
      puts "Нажмите на букву: \'q\' - чтобы выйти из приложения."
      puts 'I. Секция: Создания объектов. Введите в консоль:'
      puts '1 - чтобы создать станцию. 2 - чтобы создать поезд. 3 - чтобы создать маршрут (начальные и конечные станции маршрута).'
      puts 'II. Секция. Показать списки. Введите в консоль:'
      puts '4 - показть станции. 5 - показать поезда. 6 - показть поезда на станциях.'
      puts '7 - показать маршруты (с начальными и конечными станциями).'
      puts 'III. Секция. Нахождения поездов на станции и манипуляции ими (вагоны, маршруты, поезда, скорость). Введите в консоль:'
      puts '8 - расместить поезд на станцию, чтобы начать маршрут. 9 - дислокация поезда со станции. 10 - добавить станцию на маршрут.'
      puts '11 - удалить станцию из маршрута. 12 - показать следующую станцию на маршруте. 13 - показать предыдущую станцию на маршруте.'
      puts '14 - показать текущию станцию на маршруте. 15 - дать старт / разогнать поезд. 16 - текущий скорость поезда.'
      puts '17 - остановить поезд. 18 - прицепить вагон. 19 - отцепить вагон.'
      puts '20 - выбор направления движения на следующую станцию. 21 - выбор направления движения на предыдущую станцию'
      puts 'IV. Секция. Информация о производителе поездов. И об инстанс переменных. Введите в консоль:'
      puts '22 - присвоить имя производителя к поездам. 23 - найти инстанс поезд.'
      puts '24 - все инстанс станции. 25 - чтобы получить информацию о производителе.'
      puts 'VI. Секция. О метапрограммирование'
      puts '26 - тестирование метапрограммирования'
      puts

      puts 'Поле для ввода действия:'
      user_input = STDIN.gets.encode('UTF-8').chomp

      case user_input
      when '1'
        puts 'Секция создания станции.'
        create_station
      when '2'
        puts 'Секция создания поезда.'
        create_train
      when '3'
        puts 'Секция создания маршрута.'
        create_route
      when '4'
        puts 'Секция показа станций.'
        print_stations
      when '5'
        puts 'Секция показа поездов.'
        print_trains
      when '6'
        puts 'Секция показа поездов на станции.'
        print_trains_at_station
      when '7'
        puts 'Секция показа маршрутов.'
        print_routes
      when '8'
        puts 'Секция размещения поезда/поездов на станции.'
        locate_train
      when '9'
        puts 'Секция дислокации поезда/поездов со станции.'
        unlocate_train
      when '10'
        puts 'Секция добавления станции к маршруту.'
        add_station_to_route
      when '11'
        puts 'Секция удаления станции из маршрута.'
        delete_station_from_route
      when '12'
        puts 'Секция показа следующей станции на маршруте'
        show_next_route_station
      when '13'
        puts 'Секция показа предыдущей станции на маршруте'
        show_previous_route_station
      when '14'
        puts 'Секция показа текущей станции на маршруте'
        show_current_route_station
      when '15'
        puts 'Секция для разгона/увеличения скорости поезда.'
        train_speed
      when '16'
        puts 'Секция показа текущей скорости поезда.'
        train_current_speed
      when '17'
        puts 'Секция для остановки скорости поезда.'
        train_stopped
      when '18'
        puts 'Секция прицепления вагона к поезду.'
        add_wagoon
      when '19'
        puts 'Секция отцепления вагона к поезду.'
        delete_wagoon
      when '20'
        puts 'Секция выбора следующей станции для поезда.'
        choose_next_train_route
      when '21'
        puts 'Секция выбора предыдущей станции для поезда.'
        choose_previous_train_route
      when '22'
        puts 'Секция присвоения к поезду, названия производителя.'
        set_manufacturer
      when '23'
        puts 'Секция. Найти инстанс поезд.'
        find_instance_train
      when '24'
        puts 'Секция показа всех инстанс станций.'
        show_all_instance_stations
      when '25'
        puts 'Секция показа, названия производителя.'
        show_manufacturer
      when '26'
        puts ' Метапрограммирование'
        meta_programming
      when 'q'
        break puts 'Вы вышли из приложения!'
      else
        puts 'Попытайтесь еще раз!'
      end
    end
  end

  # ниже следуют приватные методы, они приватны, так, как не будут вызываться в других файлах приложения.
  # поэтому должны быть скрытыми

  private

  # section I
  def create_station
    puts 'Создайте станцию. Введите название:'
    station_name = STDIN.gets.encode('UTF-8').chomp
    if @stations.push Station.new(station_name)
      puts 'Станция создана!'
      return station_name
    else
      puts 'Станция не создана!'
    end
  end

  def create_train
    puts 'Создайте поезд.'
    puts 'Введите номер/название:'
    train_name = STDIN.gets.encode('UTF-8').chomp

    puts 'Введите тип поезда.'
    puts 'Надо ввести индекс типа поездов:'
    puts 'Нажмите на цифру: 1 - для типа cargo'
    puts 'Нажмите на цифру: 2 - для типа passenger'

    user_input = STDIN.gets.encode('UTF-8').to_i

    if user_input == 1
      type = 'cargo'
      @trains.push Cargo.new(train_name, type)
      puts 'Поезд типа cargo создана!'
    elsif user_input == 2
      type = 'passenger'
      @trains.push Passenger.new(train_name, type)
      puts 'Поезд типа passenger созадана!'
    else
      puts 'Поезд не создан!'
    end
  end

  def create_route
    puts 'Создайте маршрут. Выберите станцию для начальной точки отправки поезда:'
    start_index = stations_count
    if @stations.count <= 1
      puts 'Вы должны создать станции, чтобы добавить в маршрут!'
      puts 'Чтобы у маршрута было начальная и конечная станция.'
      create_station
    end

    puts 'Создайте маршрут. Выберите станцию для конечной точки прибытия:'
    end_index = stations_count

    start_point = @stations[start_index - 1]
    end_point = @stations[end_index - 1]

    @route = Route.new(start_point, end_point)
    puts "Создан маршрут: Номер маршрута: #{@route.route_number}: начало станция - #{@route.stations[0].station_name} : конечная станция - #{@route.stations[1].station_name}."
    @route.show_all_route_stations
    @routes.push(@route)
  end

  # section II
  def print_stations
    if @stations.empty?
      puts 'Нет ни одной станции!'
    else
      puts 'Список станций:'
      @stations.each { |station| puts station.station_name }
    end
  end

  def print_trains
    if @trains.empty?
      puts 'Нет ни одного поезда!'
    else
      puts 'Список поездов:'
      @trains.each { |train| puts "Название поезда: #{train.train_name} - тип: #{train.type}" }
    end
  end

  def print_trains_at_station
    puts 'Выберите станцию, чтобы увидеть находящиеся в нем поезда:'
    station_index = stations_count
    @stations[station_index - 1].show_all_trains
  end

  def print_routes
    if @routes.empty?
      puts 'Нет ни одного маршрута!'
    else
      puts 'Все станции маршрутов:'
      @routes.each(&:show_all_route_stations)
      puts '_' * 10
      puts 'Все маршруты:'
      @routes.each { |route| puts "Id-номер маршрута: #{route.route_number} - #{route.station.station_name}" }
    end
  end

  # section III
  def locate_train
    train_index = trains_count
    puts 'Введите индекс станции, чтобы разместить в нем текущий поезд, которого выбрали.'

    if train_index <= @trains.count
      if @stations.count > 0
        index = 0
        @stations.each do |station|
          index += 1
          puts "Индекс станции: #{index} - название станции: #{station.station_name}"
        end
        index_station = STDIN.gets.encode('UTF-8').to_i

        if index_station <= @stations.count
          @stations[index_station - 1].locate_train(@trains[train_index - 1])
        end

      end
    end
  end

  def unlocate_train
    puts 'Введите индекс станции, чтобы дислоцировать с него поезд, которого выбрали.'
    station_index = stations_count

    trains = @stations[station_index - 1].show_all_trains
    puts '-' * 15
    index = 0
    for train in trains do
      index += 1
      puts "Индекс: #{index} - название: #{train.train_name}"
    end

    puts 'Введите индекс поезда:'
    train_index = STDIN.gets.encode('UTF-8').to_i
    train = @trains[train_index - 1]
    @stations[station_index - 1].unlocate_train(train)
  end

  def add_wagoon
    puts 'Какому поезду вы бы хотели прицепить вагон?'
    if @trains.count > 0
      index = 0
      @trains.each do |train|
        index += 1
        puts "Индекс: #{index} - Поезд с номером: #{train.train_name} - тип поезда: #{train.type}"
      end
    end

    puts 'Введите индекс поезда для прицепления вагона:'
    train_index = STDIN.gets.encode('UTF-8').to_i

    puts 'Введите тип поезда для проверки на соответствие типа вагона:'
    puts 'Введите цифру 1 - для cargo'
    puts 'Введите цифру 2 - для passenger'
    user_input = STDIN.gets.encode('UTF-8').to_i

    @current_train = @trains[train_index - 1]
    if user_input == 1
      puts 'Введите номер вагона:'
      wagoon_number = STDIN.gets.encode('UTF-8').to_i
      puts 'Введите общее количество объема грузового вагона:'
      general_volume = STDIN.gets.encode('UTF-8').to_i
      wagoon = Cargo_wagoon.new(wagoon_number, general_volume)
      @wagoons_base[wagoon_number] = wagoon
    elsif user_input == 2
      puts 'Введите номер вагона:'
      wagoon_number = STDIN.gets.encode('UTF-8').to_i
      puts 'Введите общее количество мест пассажирского вагона:'
      place_count = STDIN.gets.encode('UTF-8').to_i
      wagoon = Passenger_wagoon.new(wagoon_number, place_count)
      @wagoons_base[wagoon_number] = wagoon
    end
    @current_train.hook_wagoons(wagoon)
  end

  def delete_wagoon
    puts 'Какому поезду вы бы хотели отцепить вагон?'
    if @trains.count > 0
      index = 0
      @trains.each do |train|
        index += 1
        puts "Индекс:#{index} - поезд с номером/названием: #{train.train_name} - тип поезда: #{train.type}"
      end
    end

    puts 'Введите индекс поезда для отцепления:'
    train_index = STDIN.gets.encode('UTF-8').to_i

    @current_train = @trains[train_index - 1]
    @current_train.detach_wagoons
    puts "Поезд с номером/названием: #{@current_train.train_name} - отцепил вагон, теперь имеет #{@current_train.wagoons.size} вагона."
  end

  def stations_count
    if @stations.count <= 0
      puts 'Нет ни одной станции, создайте!'
    elsif @stations.count > 0
      index = 0
      @stations.each do |station|
        index += 1
        puts "Индекс станции:#{index} - название станции:#{station.station_name}"
      end
      puts 'Введите индекс станции:'
      station_index = STDIN.gets.encode('UTF-8').to_i
    end
  end

  def routes_count
    if @routes.count <= 0
      puts 'Нет ни одного маршрута, создайте!'
    elsif @routes.count > 0
      puts 'Все станции маршрута:'
      index = 0
      @routes.each do |route|
        index += 1
        puts "Индекс маршрута: #{index} - маршрут: #{route.route_number}"
      end
      puts 'Введите индекс маршрута:'
      route_index = STDIN.gets.encode('UTF-8').to_i
    end
  end

  def trains_count
    if @trains.count <= 0
      puts 'Нет ни одного поезда!'
    else
      index = 0
      @trains.each do |train|
        index += 1
        puts "Индекс поезда: #{index} - Название поезда: #{train.train_name} - Тип поезда: #{train.type}"
      end
      puts 'Введите индекс:'
      train_index = STDIN.gets.encode('UTF-8').to_i
    end
  end

  def add_station_to_route
    puts 'Какую станцию хотели добавить? выберите из списка.'
    station_index = stations_count
    route_index = routes_count

    if route_index <= @routes.count
      @routes[route_index - 1].add_station(@stations[station_index - 1])
      puts 'Промежуточная станция была добавлена на маршрут!'
    end
  end

  def delete_station_from_route
    puts 'С какого маршрута вы бы хотели удалить станцию? выберите из списка.'
    route_index = routes_count

    puts 'Какую станцию вы бы хотели удалить? выберите из списка.'
    station_index = stations_count

    if route_index <= @routes.count
      @routes[route_index - 1].destroy_station(station_index)
      puts 'Станция убрана с маршрута.'
    else
      puts 'Станция не найдена! Она вне этого маршрута!'
    end
  end

  def train_speed
    puts 'Выберите поезд, чтобы разогнать.'
    train_index = trains_count
    puts 'Введите скорость:'
    speed = STDIN.gets.encode('UTF-8').to_i
    @trains[train_index - 1].speed_up(speed)
    @trains[train_index - 1].current_speed
  end

  def train_current_speed
    puts 'Выберите поезд, чтобы увидеть его текущий скорость.'
    train_index = trains_count
    @trains[train_index - 1].current_speed
  end

  def train_stopped
    puts 'Выберите поезд, чтобы остановить.'
    train_index = trains_count
    @trains[train_index - 1].stopped!
  end

  def show_next_route_station
    if @trains.count > 0
      puts 'Выберите поезд, чтобы увидеть его следующую станцию.'
      train_index = trains_count
      route_index = routes_count
      if @routes.count > 0
        route = @routes[route_index - 1]
        @trains[train_index - 1].get_route(route)
        @trains[train_index - 1].next_station
      else
        puts 'Создайте маршрут.'
      end
    else
      puts 'Создайте поезд.'
    end
  end

  def show_previous_route_station
    if @trains.count > 0
      puts 'Выберите поезд, чтобы увидеть его предыдущую станцию.'
      train_index = trains_count
      route_index = routes_count
      if @routes.count > 0
        route = @routes[route_index - 1]
        @trains[train_index - 1].get_route(route)
        @trains[train_index - 1].previous_station
      else
        puts 'Создайте маршрут.'
      end
    else
      puts 'Создайте поезд.'
    end
  end

  def show_current_route_station
    if @trains.count > 0
      puts 'Выберите поезд, чтобы увидеть его текущию станцию.'
      train_index = trains_count
      route_index = routes_count
      if @routes.count > 0
        route = @routes[route_index - 1]
        @trains[train_index - 1].get_route(route)
        @trains[train_index - 1].current_station
      else
        puts 'Создайте маршрут.'
      end
    else
      puts 'Создайте поезд.'
    end
  end

  def choose_next_train_route
    if @trains.count > 0
      puts 'Выберите поезд, чтобы отправить его на следующую станцию.'
      train_index = trains_count
      route_index =  routes_count
      if @routes.count > 0
        route = @routes[route_index - 1]
        @trains[train_index - 1].get_route(route)
        @trains[train_index - 1].move_next_route
      else
        puts 'Создайте маршрут.'
      end
    else
      puts 'Создайте поезд.'
    end
  end

  def choose_previous_train_route
    if @trains.count > 0
      puts 'Выберите поезд, чтобы отправить его на предыдущую станцию.'
      train_index = trains_count
      route_index = routes_count
      if @routes.count > 0
        route = @routes[route_index - 1]
        @trains[train_index - 1].get_route(route)
        @trains[train_index - 1].move_previous_route
      else
        puts 'Создайте маршрут.'
      end
    else
      puts 'Создайте поезд.'
    end
  end

  def set_manufacturer
    if @trains.size.zero?
      puts 'Нет ни одного поезда!'
    elsif @trains.count > 0
      puts 'Какому поезду вы бы хотели присвоить имя производителя?'
      index = 0
      @trains.each do |train|
        index += 1
        puts "Индекс: #{index} - поезд с номером: #{train.train_name} - тип поезда: #{train.type}"
      end
      puts 'Введите индекс поезда, только цифры:'
      train_index = STDIN.gets.encode('UTF-8').to_i
    end

    train = @trains[train_index - 1]

    puts 'Введите название производителя:'
    user_input = STDIN.gets.encode('UTF-8').chomp

    train.company_name = user_input
    show_manufacturer
  end

  def show_manufacturer
    puts 'Название производителя:'
    @trains.each do |train|
      puts "Номер поезда:#{train.train_name} - тип поезда:#{train.type} - производитель: #{train.company_name}"
    end
  end

  def find_instance_train
    if @trains.count > 0
      puts 'Какой поезд вы бы хотели найти?'
      index = 0
      @trains.each do |train|
        index += 1
        puts "Индекс: #{index} - поезд с номером/названием: #{train.train_name} - тип поезда: #{train.type}"
      end
      puts 'Введите индекс поезда, только цифры:'
      train_index = STDIN.gets.encode('UTF-8').to_i
    end
    train = @trains[train_index - 1]
    puts 'Найденный поезд:'
    puts Train.find(train)
  end

  def show_all_instance_stations
    if @stations.size.zero?
      puts 'Нет ни одного объекта станции!'
    else
      puts 'Все объекты станции, которые созданны на данный момент.'
      puts Station.all
    end
  end

  def meta_programming
    test = Test.new

    test.attribute_a
    puts test.attribute_a_history.inspect

    test.attribute_a = 'Vasya'
    puts test.attribute_a_history.inspect

    test.attribute_a = 'Petya'
    puts test.attribute_a_history.inspect

    puts '-' * 100

    test.attribute_b = 5
    puts test.attribute_b_history.inspect
    test.attribute_b = [1, 2, 3, 4, 5]
    puts test.attribute_b_history.inspect
    test.attribute_b = 'attribute b'
    puts test.attribute_b_history.inspect

    puts '-' * 100

    test.attribute_c = nil
    puts test.attribute_c_history.inspect
    test.attribute_c = 'attribute c'
    puts test.attribute_c_history.inspect
    test.attribute_c = %w(Ruby meta programming test)
    puts test.attribute_c_history.inspect
    test.attribute_c = rand(0..100)
    puts test.attribute_c_history.inspect

    puts '-' * 100
    puts "Strong attribute accessor"
    test.strong_attribute = "string"
    puts test.instance_variable_get(:@strong_attribute)
    puts "Instance variables: #{test.instance_variables}"
  end
end
