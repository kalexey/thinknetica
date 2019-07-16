# frozen_string_literal: true

require_relative 'train'
# class describing cargo train
class PassengerTrain < Train
  def initialize(number)
    super
    @number = number
    @type = :passenger
  end

  def add_wagon(wagon)
    return unless @current_speed.zero?
    return unless wagon.instance_of?(PassengerWagon)

    @wagons << wagon unless @wagons.include?(wagon)
  end

  def remove_wagon(wagon)
    return unless @current_speed.zero?

    @wagons.delete(wagon) if @wagons.include?(wagon)
  end
end
