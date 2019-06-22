# frozen_string_literal: true

# this program determines whether a triangle
# is rectangular, isosceles or equilateral

sides = []
(1..3).each do |i|
  print "#{i}. Enter the side length "
  sides << gets.chomp.to_i
end

a, b, c = sides.sort

if a**2 + b**2 == c**2
  puts 'Right angled triangle'
else
  puts 'Not right angled triangle'
end

puts 'Isosceles triangle' if a == b

puts 'Equilateral triangle' if a == b && b == c
