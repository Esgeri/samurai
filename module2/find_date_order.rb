months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Input day of number: '
day = gets.chomp.to_i

puts 'Input month: '
month = gets.chomp.to_i

puts 'Input year: '
year = gets.chomp.to_i

months[1] = 29 if year % 4.zero? && year % 100 != 0 || year % 400.zero?

date_number = 0

counter = 0

while counter < month
  date_number += months[counter]
  counter += 1
end

date_number += day

puts "Now is #{date_number} day of the year."
