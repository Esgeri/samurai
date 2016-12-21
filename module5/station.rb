class Station
  attr_accessor :station_name, :trains

  @@stations = []

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @@stations << self
  end

  def self.all
    puts "Все станции, которые созданны на данный момент."
    @@stations
  end

  def arrive_train(train)
    if @trains.include? train
      puts "Поезд с номером: #{train.number} уже находиться в этой станции."
    else
      @trains << train
      puts "Поезд с номером: #{train.number} размещен на станцию: #{@station_name}."
    end
  end

  def show_all_trains
    if @trains.empty?
      puts "Нет ни одного поезда на станции: #{@station_name}."
    else
      puts "Список поездов на станции: #{@station_name} на текущий момент."
      @trains.each { |train| puts train.number }
    end
  end

  def count_train_by_type(train_type)
    @trains.select{|train| train.type == train_type}.size
  end

  def dispatch_train(train)
    if @trains.include? train
      puts "Поезд с номером: #{train.number} отбывает со станции #{@station.station_name}."
      @trains.delete(train)
    else
      puts "Поезд с номером: #{train.number} не распологается на станции: #{@station_name}."
    end
  end
end
