puts 'Введите значение А:'
a = gets.to_f
puts 'Введите значение B:'
b = gets.to_f
puts 'Введите значение C:'
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
  puts "Дискриминант равен #{d}"
  puts 'У уравнения нет решения.'
elsif d.zero?
  result = (-b - d) / (2 * a)
  puts "Дискриминант равен #{d}"
  puts "x = #{result}"
elsif d > 0
  result_x1 = (-1 * b - Math.sqrt(d)) / (2.0 * a)
  result_x2 = (-1 * b - Math.sqrt(d)) / (2.0 * a)
  puts "Дискриминант равен #{d}"
  puts "x1 = #{result_x1}"
  puts "x1 = #{result_x2}"
end
