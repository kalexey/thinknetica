months_in_year = { January: 31, February: { leap: 29, no_leap: 28 },\
                   March: 31, April: 30, May: 31,\
                   June: 30, July: 31, August: 31,\
                   September: 30, October: 31, November: 30, December: 31 }

print 'Enter day '
day = gets.chomp.to_i

print 'Enter month '
month = gets.chomp.to_i

print 'Enter year '
year = gets.chomp.to_i

if (year % 400).zero?
  leap_year = :leap
elsif (year % 100).zero?
  leap_year = :no_leap
elsif (year % 4).zero?
  leap_year = :leap
end

n = day
months_in_year.each_with_index do |(key, value), index|
  next unless index < month - 1

  n += if key != :February
         value
       else
         value[leap_year]
       end
end

puts "Day number #{n}"
