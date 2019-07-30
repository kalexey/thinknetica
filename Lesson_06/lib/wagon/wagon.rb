# frozen_string_literal: true
# frozen_string_literal: true

require_relative '../manufacturer'
require_relative '../validators/wagon_validator'
# class describing wagon
class Wagon
  attr_reader :type

  include Manufacturer
  include WagonValidator

  def initialize
    @type = nil
    validate_wagon!
  end
end
