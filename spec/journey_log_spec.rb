require 'journey_log'
require 'journey'

describe JourneyLog do
  let(:log) { JourneyLog.new(Journey) }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'given a journey when initializing then saves journey instance' do
    expect(log.journey_class).to eq(Journey)
  end

  it 'given no current journey when starting journey then create journey with entry station' do
    log.start(entry_station)
    expect(log.journey.entry_station).to eq entry_station
  end

  it 'given entry station when ending journey then add exit station to journey' do
    log.start(entry_station)
    log.finish(exit_station)
    expect(log.journeys.last.exit_station).to eq exit_station
  end

  it 'given there is a completed journey when requesting history return list of past journeys' do
    log.start(entry_station)
    log.finish(exit_station)
    expect(log.journeys.last).to have_attributes(entry_station: entry_station, exit_station: exit_station)
  end

  it 'given journey stated when starting again at new station then entry station is new station' do
    new_station = 'New Station'
    log.start(entry_station)
    log.start(new_station)
    expect(log.journey.entry_station).to eq new_station
  end
end
