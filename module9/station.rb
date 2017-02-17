class Station
  include Validation

  STATION_NAME = /^[a-zа-я]|\d+$/i

  attr_accessor :station_name, :trains

  validate :station_name, :valid_presence
  validate :station_name, :valid_format, :STATION_NAME

  @@stations = []

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @@stations << self
    # validate!
  end

  def self.all
    @@stations
  end

  def locate_train(train)
    if @trains.include? train
      puts "Поезд с номером/название: #{train.train_name} уже находиться в этой станции."
    else
      @trains << train
      puts "Поезд с номером/название: #{train.train_name} размещен на станцию: #{@station_name}."
    end
  end

  def unlocate_train(train)
    if @trains.include? train
      puts "Поезд с номером/названием: #{train.train_name} отбывает со станции"
      @trains.delete(train)
    else
      puts "Поезд с номером/названием: #{train.train_name} не распологается на станции."
    end
  end

  def show_all_trains
    if @trains.empty?
      puts "Нет ни одного поезда на станции: #{@station_name}."
    else
      puts "Список поездов на станции: #{@station_name} на текущий момент."
      @trains.each { |train| puts "Название: #{train.train_name} тип: #{train.type} количество вагонов: #{train.wagoons.count}" }
    end
  end

  def count_train_by_type(train_type)
    @trains.select { |train| train.type == train_type }.size
  end

  def block
    @trains.each { |train| yield(train) }
  end
end
