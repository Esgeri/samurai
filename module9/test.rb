require_relative 'modules/accessor'

class Test
  include Accessor

  attr_accessor_with_history :attribute_a, :attribute_b, :attribute_c
end

test = Test.new

test.attribute_a
puts test.attribute_a_history.inspect

test.attribute_a = 'Vasya'
puts test.attribute_a_history.inspect

test.attribute_a = 'Petya'
puts test.attribute_a_history.inspect

puts '-' * 100

test.attribute_b = 5
puts test.attribute_b_history.inspect
test.attribute_b = [1, 2, 3, 4, 5]
puts test.attribute_b_history.inspect
test.attribute_b = 'attribute b'
puts test.attribute_b_history.inspect

puts '-' * 100

test.attribute_c = nil
puts test.attribute_c_history.inspect
test.attribute_c = 'attribute c'
puts test.attribute_c_history.inspect
test.attribute_c = %w(Ruby meta programming test)
puts test.attribute_c_history.inspect
test.attribute_c = rand(0..100)
puts test.attribute_c_history.inspect

puts '-' * 100
puts "Instance variables: #{test.instance_variables}"
