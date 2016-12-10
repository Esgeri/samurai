# Имеет название, которое указывается при ее создании

# Может принимать поезда (по одному за раз)

# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских

# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).


class Station
  
  attr_accessor :station_name, :trains

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def arrive_train(train)
    if @trains.include? train
  	  puts "This #{train.number} is already located on the station."
    else
      @trains << train
      puts "Train #{train.number} arrived to #{@station_name} station."
    end
  end

  def show_all_trains
    if @trains.empty?
      puts "No one train on the station: #{@station_name}."
    else
      puts "List of trains on station #{@station_name} at current moment:"
      @trains.each { |train| puts train.number }
    end
  end

  def count_train_by_type(train_type)
    @trains.select{|train| train.type == train_type}.size
  end

  def dispatch_train(train)
    if @trains.include? train 
      puts "The train #{train.number} is dispatching...."
      @trains.delete(train)
    else
  	  puts "The train #{train.number} is not located on the station #{@station_name}."
    end
  end

end
