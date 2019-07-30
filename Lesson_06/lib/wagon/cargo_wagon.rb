# frozen_string_literal: true

require_relative 'wagon'

# class describing cargo wagon
class CargoWagon < Wagon
  def initialize
    super
    @type = :cargo
  end
end
