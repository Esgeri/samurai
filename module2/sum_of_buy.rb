goods = {}

loop do
  puts "Enter name of good: (or enter word: /'stop/' to stop iteration!)"
  name = gets.chomp.to_s

  break puts '*' * 65 if name == 'stop'

  puts 'Enter price:'
  price = gets.to_f

  puts 'Enter count of good:'
  count = gets.to_i
  puts '*' * 65

  goods[name] = {
    price: price,
    count: count
  }
end

total_price = 0
goods.each do |name, _price|
  total_price = goods[name][:price] * goods[name][:count]
  puts "The #{name} total price is #{total_price}."
end
puts '*' * 65

total_cost = 0
goods.each do |name, _total|
  total_cost += goods[name][:price] * goods[name][:count]
end
puts "Total cost of goods: #{total_cost}"
