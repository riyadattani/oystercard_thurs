require_relative "oystercard"

class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @in_use = false
  end

  def start(entry_station)
    @entry_station = entry_station
    @in_use = true
    self
  end

  def finish(exit_station)
    @exit_station = exit_station
    @in_use = false
    self
  end

  def in_journey?
    @in_use
  end

  def complete?
    @entry_station && @exit_station != nil
  end

  def fare(penalty = PENALTY_FARE)
    complete? ? Oystercard::MINIMUM_FARE : PENALTY_FARE
  end

end
