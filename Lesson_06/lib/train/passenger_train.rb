# frozen_string_literal: true

require_relative 'train'
# class describing cargo train
class PassengerTrain < Train
  def initialize(number)
    super
    @number = number
    @type = :passenger
  end
end
