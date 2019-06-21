# frozen_string_literal: true

# this program calculate ideal weight
# by formula iw[kg] = height[cm] - 110

print 'Enter your name '
name = gets.chomp

print 'Enter your height in centimeters '
height = Integer(gets.chomp)

ideal_weight = height - 110

if ideal_weight >= 0
  puts "#{name}, your ideal weight is #{ideal_weight} kg"
else
  puts 'Your weight is ideal'
end
