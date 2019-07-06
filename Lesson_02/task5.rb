months_in_year = { January: 31, February: 28,
                   March: 31, April: 30, May: 31,
                   June: 30, July: 31, August: 31,
                   September: 30, October: 31, November: 30, December: 31 }

print 'Enter day '
day = gets.chomp.to_i

print 'Enter month '
month = gets.chomp.to_i

print 'Enter year '
year = gets.chomp.to_i

months_in_year[:February] += 1 if (year % 400).zero? ||
                                  ((year % 100).zero? && !(year % 4).zero?)

months = months_in_year.take(month - 1)
day_number = day + months.sum { |(_key, value)| value }

puts day_number
