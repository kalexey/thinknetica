# frozen_string_literal: true

require_relative 'wagon'
require_relative '../manufacturer'

# class describing cargo wagon
class CargoWagon < Wagon
  def initialize
    super
    @type = :cargo
  end
end
