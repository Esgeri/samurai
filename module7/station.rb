class Station
  attr_accessor :station_name, :trains

  @@stations = []

  STATION_NAME = /^[a-zа-я]|\d+$/i

  def initialize(station_name)
    @station_name = station_name
    validate!
    @trains = []
    @@stations << self
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
      @trains.each { |train| puts "Название: #{train.train_name} тип: #{train.type} количество вагонов: #{train.wagoons.count}"  }
    end
  end

  def count_train_by_type(train_type)
    @trains.select{|train| train.type == train_type}.size
  end

  def block(&block)
    @trains.each { |train| block.call(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise "Название станции не может быть пустым!" if station_name.nil?
    raise "Название станции имеет не правильный формат!" if station_name !~ STATION_NAME
  end
end
