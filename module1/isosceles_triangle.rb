puts "Введите сторону А - треугольника:"
a = gets.to_f
puts "Введите сторону В - треугольника:"
b = gets.to_f
puts "Введите сторону С - треугольника:"
c = gets.to_f

max = 0
x = 0
y = 0

if a + b <= c || a + c <= b || b + c <= a
  puts "Треугольника не существует!"
else
  
  if a > b && a > c
    max = a
    x = b 
    y = c 
  elsif b > a && b > c
    max = b 
    x = a 
    y = c 
  elsif c > a && c > b 
    max = c
    x = a 
    y = b 
  end

  if max**2 == x**2 + y**2
    if a == b && b == c && a == c 
      puts "Треугольник равнобедренный и равносторонний."
    else
      puts "Треугольник равнобедренный и прямоугольный."
    end
  else
    puts "Не равнобедренный треугольник!"
  end

end