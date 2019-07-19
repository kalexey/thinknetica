# frozen_string_literal: true

require_relative 'wagon'

# class describing passenger wagon
class PassengerWagon < Wagon
  def initialize
    super
    @type = :passenger
  end
end
