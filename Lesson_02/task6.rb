goods = {}

loop do
  print 'Enter name of product '
  name = gets.chomp.to_s

  break if name.casecmp('stop').zero?

  print 'Enter unit price '
  unit_price = gets.chomp.to_f

  print 'Enter the amount of purchased goods '
  amount = gets.chomp.to_f

  goods[name] = { unit_price: unit_price, amount: amount }
end

total_amount = 0.0

goods.each do |key, value|
  puts "name #{key}, unit price #{value[:unit_price]}, amount #{value[:amount]}"
  total_amount += value[:unit_price] * value[:amount]
end

puts "Total amount #{total_amount}"
