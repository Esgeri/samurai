fibonacci = [0, 1]

counter = 1

while fibonacci.last + fibonacci[-2] < 100
  fibonacci[counter] = fibonacci.last + fibonacci[-2]
  counter += 1 
end

puts fibonacci