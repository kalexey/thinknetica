# frozen_string_literal: true

# this program solve square equation

print 'Enter coeffecient a '
a = gets.chomp.to_f

print 'Enter coeffecient b '
b = gets.chomp.to_f

print 'Enter coeffecient c '
c = gets.chomp.to_f

# calculate determinant D

d = b**2 - 4 * a * c
sqrt_d = Math.sqrt(d.abs)
if d.positive?
  x1 = (-b - sqrt_d) / (2 * a)
  x2 = (-b + sqrt_d) / (2 * a)
  puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d.negative?
  puts "D = #{d}, the equation has no real roots "
else
  x12 = (-b) / (2 * a)
  puts "D = #{d}, x12 = #{x12}"
end
