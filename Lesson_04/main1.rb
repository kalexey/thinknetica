# frozen_string_literal: true

require_relative 'station'
require_relative 'route'

require_relative 'train/passenger_train'
require_relative 'train/cargo_train'

require_relative 'wagon/passenger_wagon'
require_relative 'wagon/cargo_wagon'

class MenuItem
  attr_reader :displayed_string
  def initialize(displayed_string)
    @displayed_string = displayed_string
  end

  def operation
    yield
  end
end

class Menu
  attr_accessor :menu_items, :operations
  def initialize
    @menu_items = []
    @operations = []
  end

  def init_menu(strings, operations)
    @menu_items = strings
    @operations = operations
  end

  def show
    @menu_items.each_with_index { |s, i| puts "#{i}. #{s}" }
  end

  def read_index
    gets.chomp.to_i
  end

  def encode(p) 
    b = p.call
    puts b
    p.call
  end
end

MENU = %w[item0 item1 item2 item3].freeze
op0 = proc do
  puts 'operation0'
  false
end

op1 = proc do
  puts 'operation1'
  true
end

op2 = proc do
  puts 'operation02'
end

op3 = proc do
  puts 'operation03'
end

operations = [op0, op1, op2, op3]

menu0 = Menu.new
menu0.init_menu(MENU, operations)
puts menu0.inspect
menu0.show
menu0.encode menu0.operations[0]
menu0.encode menu0.operations[1]
loop do
  index = gets.chomp.to_i
  break if (0..2).to_a.include?(index)
end