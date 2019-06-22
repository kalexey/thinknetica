# frozen_string_literal: true

# this program calculate square of triangle
# by formula S = 1/2*a*h

print 'Enter the base of the triangle '
base = gets.chomp.to_f

print 'Enter the height of the triangle '
height = gets.chomp.to_f

square = 0.5 * base * height

puts "The square of the triangle S = #{square}"
