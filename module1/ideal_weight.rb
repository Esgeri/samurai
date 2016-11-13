puts "What's your name?"

name = gets.chomp

puts "What's your height?"

height = gets.to_i

weight = height - 110

if weight <= 0
  puts "#{name} you have already optimal weight!"
else
  puts "#{name} your weight is #{weight}."
end
