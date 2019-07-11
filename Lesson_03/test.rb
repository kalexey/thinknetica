require './station'
require './route'
require './train'

# station functional test

# create
s = Station.new('ABC')
puts s.to_s
puts

t1 = Train.new('1234', 'passenger', 5)
t2 = Train.new('5678', 'cargo', 10)

# receive train
s.receive_train(t1)
puts 'Receiving train t1'
puts s.to_s
puts

s.receive_train(t2)
puts 'Receiving train t2'
puts s.to_s
puts

# list of trains
puts 'list of trains'
puts s.trains_list
puts

# list of trains by type
puts "list of trains by type 'cargo'"
puts s.trains_list_by_type('cargo')
puts

puts "list of trains by type 'passenger'"
puts s.trains_list_by_type('passenger')
puts

# send train
s.send_train(t1)
puts s.trains_list
puts

s.send_train(t2)
puts s.trains_list
puts

# route functional test
s_first = Station.new('first')
s_last = Station.new('last')
s_mid = Station.new('mid')

# create
r = Route.new(s_first, s_last)
puts 'Create route'
puts r.to_s
puts

# add station
r.add_station(s_mid)
puts 'add station'
puts r.to_s
puts

# list station
puts 'list station'
puts r.list_route_stations
puts

# remove station
r.remove_station(s_mid)
puts 'remove station'
puts r.to_s
puts

# train functional test

s0 = Station.new('s0')
s1 = Station.new('s1')
s2 = Station.new('s2')
s3 = Station.new('s3')

route0 = Route.new(s0, s3)
route0.add_station(s1)
route0.add_station(s2)

train0 = Train.new('1111', 'passenger', 10)
# set speed
train0.run(100)
# return current speed
puts 'Train0 current speed after run(100) v = ' + train0.current_speed.to_s
# stop
train0.stop
puts 'Train0 current speed after stop v = ' + train0.current_speed.to_s

puts 'Speed = ' + train0.current_speed.to_s
# number of wagons
puts 'Train0 number of wagons ' + train0.nr_wagons.to_s

# add wagon
train0.add_wagon
puts 'Train0 number of wagons after adding wagon ' + train0.nr_wagons.to_s

# remove wagon
train0.remove_wagon
puts 'Train0 number of wagons after removing ' + train0.nr_wagons.to_s

train0.run(100)
puts 'Speed = ' + train0.current_speed.to_s

# number of wagons
puts 'Train0 number of wagons ' + train0.nr_wagons.to_s

# add wagon
train0.add_wagon
puts 'Train0 number of wagons after adding wagon ' + train0.nr_wagons.to_s

# remove wagon
train0.remove_wagon
puts 'Train0 number of wagons after removing ' + train0.nr_wagons.to_s
train0.stop

train0.route(route0)

puts 'Train is added to first station by default'
puts train0.current_route.stations[0].trains

puts 'move next station'
train0.move_next_station
puts train0.current_route.stations[1].trains

puts 'move next station'
train0.move_next_station
puts train0.current_route.stations[2].trains

puts 'move next station'
train0.move_next_station
puts train0.current_route.stations[3].trains

train0.move_next_station

puts 'move prev station'
train0.move_prev_station
puts train0.current_route.stations[2].trains

puts 'move prev station'
train0.move_prev_station
puts train0.current_route.stations[1].trains

puts 'prev station'
train0.move_prev_station
puts train0.current_route.stations[0].trains
train0.move_prev_station
