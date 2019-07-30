# frozen_string_literal: true

module WagonValidator
  def valid?
    validate_wagon!
    true
  rescue StandardError
    false
  end

  private

  # validation before Wagon object creation
  def validate_wagon!
    raise "#{self} is not a valid Wagon object" unless is_a? Wagon
    raise "#{type} is not a valid Wagon type" unless [nil, :cargo, :passenger].include?(@type)
  end
end
