# frozen_string_literal: true

module StationValidator
  def valid?
    validate_station!(@name)
    true
  rescue StandardError
    false
  end

  private

  NAME_REGEX = /^[a-zA-Z]{1}[a-zA-Z0-9]{1,2}$/i.freeze
  NAME_MAX_LENGTH = 3

  # validatition before Station object creation
  def validate_station!(name)
    message = "Station name #{name} does not match format #{NAME_REGEX.source}"

    raise message unless name =~ NAME_REGEX
  end

  def validate_send_train!(train)
    raise "#{train} is not train object" unless train.is_a?(Train)
    raise 'This train is not at this station' unless @trains.include?(train)
  end

  def validate_receive_train!(train)
    raise "#{train} is not train object" unless train.is_a?(Train)
  end
end
