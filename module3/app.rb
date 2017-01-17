require_relative 'station'
require_relative 'route'
require_relative 'train'

moscow = Station.new('Moscow')
kiev = Station.new('Kiev')
minsk = Station.new('Minsk')
odessa = Station.new('Odessa')
bishkek = Station.new('Bishkek')

moscow_train = Train.new(123, 'cargo', 18)
bishkek_train = Train.new(312, 'passenger', 25)
minsk_train = Train.new(444, 'cargo', 15)

bishkek_moscow_route = Route.new(bishkek, moscow)
moscow_kiev_route = Route.new(moscow, kiev)

# moscow station
puts "Station name: #{moscow.station_name}"
puts
moscow.arrive_train(moscow_train)
moscow.arrive_train(bishkek_train)
moscow.arrive_train(minsk_train)
puts
moscow.show_all_trains
puts
puts "#{moscow.station_name} station has: #{moscow.trains.size} trains."
puts "Cargo: #{moscow.count_train_by_type('cargo')}"
puts "Passanger trains: #{moscow.count_train_by_type('passenger')}"
puts
moscow.dispatch_train(minsk_train)
puts
moscow.show_all_trains
puts
puts "#{moscow.station_name} station has: #{moscow.trains.size} trains."
puts "Cargo: #{moscow.count_train_by_type('cargo')}"
puts "Passanger trains: #{moscow.count_train_by_type('passenger')}"
puts
puts '=' * 100

# train area
puts 'Train info:'
moscow_train.wagoons_count
puts
moscow_train.current_speed
puts
moscow_train.hook_wagoons
puts

moscow_train.get_route(moscow_kiev_route)
puts "Route: start point - #{moscow_kiev_route.stations[0].station_name}"
puts "Route: end point - #{moscow_kiev_route.stations[1].station_name}"
puts

moscow_train.speed_up(22)
moscow_train.current_speed
moscow_train.speed_up(22)
moscow_train.current_speed
moscow_train.stop
moscow_train.current_speed
moscow_train.detach_wagoons
puts

moscow_kiev_route.add_station(minsk)
moscow_kiev_route.add_station(odessa)
puts
moscow_kiev_route.show_all_route_stations
puts
moscow_kiev_route.destroy_station(odessa)
puts
moscow_kiev_route.show_all_route_stations
puts '=' * 100
puts

moscow_train.current_station
moscow_train.next_station
moscow_train.move_next_route
moscow_train.current_station
moscow_train.next_station
puts
moscow_train.previous_station
puts

moscow_train.move_previous_route
puts

moscow_train.current_station
moscow_train.next_station
puts
puts '=' * 100

# bishkek station
puts
puts "Station name: #{bishkek.station_name}"
puts
bishkek.show_all_trains
puts
puts '=' * 100
puts
