# frozen_string_literal: true

# this program calculate square of triangle
# by formula S = 1/2*a*h

print 'Enter the base of the triangle '
base = Float(gets.chomp)

print 'Enter the height of the triangle '
height = Float(gets.chomp)

square = 0.5 * base * height

puts "The square of the triangle S = #{square}"
