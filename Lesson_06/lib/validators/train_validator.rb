# frozen_string_literal: true

module TrainValidator
  def valid?
    validate_train!(@number)
    true
  rescue StandardError
    false
  end

  private

  NUMBER_REGEX = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  # validation before Train object creation
  def validate_train!(number)
    message = "Train number #{number} does not match format #{NUMBER_REGEX.source}"
    raise message unless number =~ NUMBER_REGEX
  end

  # validation before speed changing
  def validate_run!(speed)
    raise "Speed #{speed} is < 0" if speed.negative?
  end

  def validate_route!(route)
    raise "#{route} is not Route object" unless route.is_a?(Route)
  end

  def validate_add_wagon!(wagon)
    raise 'The train is moving' unless @current_speed.zero?
    raise 'Not suitable wagon type' unless wagon.type == @type
    raise 'Wagon already added' if @wagons.include?(wagon)
  end

  def validate_remove_wagon!(wagon)
    raise 'Wagons list empty' if @wagons.empty?
    raise 'The train is moving' unless @current_speed.zero?
    raise 'Not suitable wagon type' unless wagon.type == @type
    raise 'This wagon is not included in the train' unless @wagons.include?(wagon)
  end

  def validate_next_station!
    raise 'Unassigned route' if @current_route.nil?
    raise 'Last station' if @current_route.stations.last == @current_station
  end

  def validate_prev_station!
    raise 'Unassigned route' if @current_route.nil?
    raise 'First station' if @current_route.stations.first == @current_station
  end
end
