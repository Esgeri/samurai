fibonacci = [0, 1]

while fibonacci.last + fibonacci[-2] < 100
  fibonacci << fibonacci.last + fibonacci[-2]
end

puts fibonacci
