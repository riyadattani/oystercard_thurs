# require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_list
  DEFAULT_LIMIT = 90
  MINIMUM = 1
  MINIMUM_FARE = 1

  def initialize(journey = Journey)
    @balance = 0
    @journey_list = []
    @journey = journey
  end

  def top_up(amount)
    raise "Top-up exceeds £#{DEFAULT_LIMIT} balance limit. Add lower amount." if @balance + amount > DEFAULT_LIMIT

    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if @balance < MINIMUM
    journey = @journey.new
    journey.start(entry_station)
    add(journey)
  end

  def touch_out(exit_station)
    @journey_list.each {|journey| journey.finish(exit_station) if journey.in_journey? == true }
    deduct(MINIMUM_FARE)
  end

  private

  def add(journey)
    @journey_list << journey
  end

  def deduct(amount)
    @balance -= amount
  end

end
