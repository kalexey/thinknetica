# frozen_string_literal: true

# class describing wagon
class Wagon
  attr_reader :type
  def initialize
    @type = nil
  end

  def show_info
    puts "wagon type : #{@type}"
  end
end
