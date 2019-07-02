# frozen_string_literal: true

fibb_array = [0, 1]
loop do
  next_value = fibb_array[-1] + fibb_array[-2]
  break if next_value > 100

  fibb_array.push(next_value)
end

fibb_array.each { |x| print "#{x} " }
