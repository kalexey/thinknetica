# frozen_string_literal: true

# this program solve square equation

print 'Enter coeffecient a '
a = Float(gets.chomp)

print 'Enter coeffecient b '
b = Float(gets.chomp)

print 'Enter coeffecient c '
c = Float(gets.chomp)

# calculate determinant D

D = b**2 - 4 * a * c
C = Math.sqrt(D.abs)
if D.positive?
  x1 = (-b - C) / (2 * a)
  x2 = (-b + C) / (2 * a)
  puts "D = #{D}, x1 = #{x1}, x2 = #{x2}"
elsif D.negative?
  puts "D = #{D}, the equation has no real roots "
else
  x12 = (-b) / (2 * a)
  puts "D = #{D}, x12 = #{x12}"
end
