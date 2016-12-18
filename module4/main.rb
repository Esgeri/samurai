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
      puts "\'q\' - enter to quit the programm"
      puts
      puts "I. Section: Create."
      puts "Input to console:"
      puts "1 - create station"
      puts "2 - create train"
      puts "3 - create route"
      puts  
      puts "II. Section: Print lists."
      puts "Input to console:"
      puts "4 - print stations"
      puts "5 - print trains"
      puts "6 - print trains at station"
      puts "7 - print routes (start point, end point)"
      puts  
      puts "III. Section: Train location & manupulate."
      puts "Input to console:"
      puts "8 - locate at station to start from route"
      puts "9 - add wagoon"
      puts "10 - delete wagoon"
      
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
      when 'q' 
        break puts "You are quit from programm!"
      else
        puts "Try again!"
      end
    end
  end

# ниже следуют приватные методы, они приватны, так, как не будут вызываться в других файлах приложения.
# поэтому должны быть скрытыми
private
  # section I
  def create_station
    puts "Create station. Input name:"
    station_name = STDIN.gets.encode('UTF-8').chomp
    if @stations.push Station.new(station_name)
      puts "The station was create!"
      return station_name
    else
      puts "Station no create!"
    end
  end

  def create_train
    puts "Create train. Input number:"
    number = STDIN.gets.encode('UTF-8').to_i
    puts "Input type of train: cargo or passenger"
    type = STDIN.gets.encode('UTF-8').chomp
    if type == 'cargo'
      @trains.push Cargo.new(number, type)
      puts "Train cargo was created!"
    elsif type == 'passenger'
      @trains.push Passenger.new(number, type)
      puts "Train passenger was created!"
    else
      puts "Train no create!"
    end          
  end

  def create_route
    if @stations.count > 1
      puts "Create route. Choose station for start point:"
      index = 0
      @stations.each do |station|
        index +=1
        puts "Station index: #{index} - name: #{station.station_name}"
        puts "Not enough stations to add route!" if @stations.count == 1
      end
      puts "Input station index:"
      start_index = STDIN.gets.encode('UTF-8').to_i

      puts "Create route. Choose station for end point:"
      index = 0
      @stations.each do |station|
        index +=1
        puts "Station index: #{index} - name: #{station.station_name}"
      end
      puts "Input next station index:"
      end_index = STDIN.gets.encode('UTF-8').to_i

      start_point = @stations[start_index-1]
      end_point = @stations[end_index-1]

      @route = Route.new(start_point, end_point)
      puts "Was created routes: start - #{@route.stations[0].station_name} : end - #{@route.stations[1].station_name}."
      @route.show_all_route_stations
      @routes.push(@route)
    else
      puts "You must create stations to add route!" if @stations.count == 1
    end
  end

  # section II
  def print_stations
    if @stations.empty? 
      puts "No one station!"
    else
      puts "List of stations:"
      @stations.each { |station| puts station.station_name }
    end
  end

  def print_trains
    if @trains.empty?
      puts "No one train!"
    else
      puts "List of trains:"
      @trains.each { |train| puts "Number:#{train.number} - type:#{train.type}" }
    end
  end

  def print_trains_at_station
    if @stations.count > 0
      puts "Choose station to see it is trains:"
      index = 0
      @stations.each do |station|
        index += 1
        puts "Station index: #{index} - name: #{station.station_name}"
      end
      
      puts "Input station index:"
      station_index = STDIN.gets.encode('UTF-8').to_i

      @stations[station_index-1].show_all_trains
    end
  end

  def print_routes
    if @routes.empty? 
      puts "No one route!"
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
        puts "Train index: #{index} - train number: #{train.number} - type: #{train.type}"
      end

      puts "Input index:"
      index_number = STDIN.gets.encode('UTF-8').to_i

      if index_number <= @trains.count 
        if @stations.count > 0 
          puts "Input station name to locate current train"
          index = 0
          @stations.each do |station|
            index +=1
            puts "Station index: #{index} - name: #{station.station_name}"
          end
          index_station = STDIN.gets.encode('UTF-8').to_i
          if index_station <= @stations.count 
            @stations[index_station-1].arrive_train(@trains[index_number-1])
          end
        end
      end
    else
      puts "No any train!"
    end
  end
 
  def add_wagoon
    puts "What train would you like hook wagoon?"
    if @trains.count > 0
      index = 0
      @trains.each do |train|
        index +=1
        puts "Train number: #{train.number} - train type: #{train.type}"
      end
    end

    puts "Input train number:"
    number = STDIN.gets.encode('UTF-8').to_i
    puts "Input train type:"
    type = STDIN.gets.encode('UTF-8').chomp

    @current_train = @trains.find { |train| train.number == number }
    # проверка на тип вагона, что грузовые поезда могут подсоединять только грузовые вагоны
    if @current_train.type == 'cargo'
      wagoon = Cargo_wagoon.new
    elsif @current_train.type == 'passenger'
      wagoon = Passenger_wagoon.new
    end
    @current_train.hook_wagoons(wagoon)
  end

  def delete_wagoon
    puts "Input train number:"
    number = STDIN.gets.encode('UTF-8').to_i
    @current_train = @trains.find { |train| train.number == number }
    @current_train.detach_wagoons
  end 
end
