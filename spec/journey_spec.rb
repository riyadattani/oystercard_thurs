require 'journey'
require 'oystercard'

describe Journey do
  let(:journey) { Journey.new }

  # it "should return false for in_journey when journey hasn't started" do
  #   expect(journey).to_not be_in_journey
  # end

  let(:entry_station) { double :station }

  it "should start a journey" do
    expect(journey.start(entry_station)).to eq journey
  end

  let(:exit_station) { double :station }
  before { journey.start(entry_station) }

  it "should finish the journey" do
    expect(journey.finish(exit_station)).to eq journey
  end

  it "should change in journey status to true when card touched in" do
    expect(journey).to be_in_journey
  end

  it "should should tell us whether the journey is complete" do
    journey.finish(exit_station)
    # expect(journey.in_journey?).to eq false
    expect(journey).to_not be_in_journey
  end

  it { is_expected.to respond_to(:complete?) }

  it "should return true if exit_station and entry_station is not nil" do
    journey.start(entry_station)
    journey.finish(exit_station)
    expect(journey).to be_complete
  end

  it "should return false if either station is not nil" do
    journey.start(entry_station)
    expect(journey).to_not be_complete
  end

  it { is_expected.to respond_to(:fare) }

  it "has a penalty fare by default" do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it "should return the minimum if journey is complete" do
    journey.start(entry_station)
    journey.finish(exit_station)
    expect(journey.fare).to eq Oystercard::MINIMUM_FARE
  end

end
