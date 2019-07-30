# frozen_string_literal: true

require_relative 'train'

# class describing cargo train
class CargoTrain < Train
  def initialize(number)
    super
    @number = number
    @type = :cargo
  end
end
