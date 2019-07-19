# frozen_string_literal: true

require_relative 'lib/station'
require_relative 'lib/route'

require_relative 'lib/train/passenger_train'
require_relative 'lib/train/cargo_train'
require_relative 'lib/train/train'

require_relative 'lib/wagon/passenger_wagon'
require_relative 'lib/wagon/cargo_wagon'
require_relative 'lib/wagon/wagon'
=begin
# проверка свойства manufacturer класса Wagon
cw0 = CargoWagon.new
puts 'инстанс переменные до присваивания '
puts cw0.instance_variables
cw0.manufacturer = 'General Motors'
puts 'инстанс переменные после присваивания '
puts cw0.instance_variables
puts 
puts '@manufacturer=' + cw0.manufacturer
puts

# проверка свойства manufacturer класса Wagon
pw0 = PassengerWagon.new
puts 'инстанс переменные до присваивания '
puts pw0.instance_variables
pw0.manufacturer = 'ЧМЗ'
puts 'инстанс переменные после присваивания '
puts pw0.instance_variables
puts 
puts '@manufacturer=' + pw0.manufacturer

=end
#проверка работы instance, register_istance

s0 = Station.new("a")
puts Station.instances.to_s

s1 = Station.new("a")
puts Station.instances.to_s

r0 = Route.new(s0, s1)
puts Route.instances.to_s

r1 = Route.new(s0, s1)
puts Route.instances.to_s



t2 = CargoTrain.new('bbbb')
t3 = CargoTrain.new('cccc')
t1 = CargoTrain.new('aaaa')

puts CargoTrain.instances.to_s
puts PassengerTrain.instances.to_s
