# frozen_string_literal: true

require_relative '../manufacturer'
# class describing wagon
class Wagon
  attr_reader :type

  include Manufacturer

  def initialize
    @type = nil
  end

  def show_info
    puts "wagon type : #{@type}"
  end
end
