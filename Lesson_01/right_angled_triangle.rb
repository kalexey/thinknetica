# frozen_string_literal: true

# this program determines whether a triangle
# is rectangular, isosceles or equilateral

sides = [0.0, 0.0, 0.0]

sides.each_index do |index|
  print "#{index + 1}. Enter the side length "
  sides[index] = Integer(gets.chomp)
end

sides = sides.sort

if sides[0]**2 + sides[1]**2 == sides[2]
  puts 'Right angled triangle'
else
  puts 'Not right angled triangle'
end

puts 'Isosceles triangle' if sides[0] == sides[1]

puts 'Equilateral triangle' if sides[0] == sides[1] && sides[1] == sides[2]

sides.each do |value|
  puts "Side #{value}"
end
