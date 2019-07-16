# frozen_string_literal: true

# class for describing station
class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains.push(train)
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_list
    @trains
  end

  def trains_list_by_type(type)
    @trains.map { |t| t if t.type == type }
  end
end
