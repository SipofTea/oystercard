require 'station'

describe Station do
  let(:station) { Station.new }
  let(:test_name) { double :test_name }
  let(:test_zone) { double :test_zone }
  it 'given station name set when require name then return name' do
    station.name(test_name)
    expect(station.station_name).to eq test_name
  end
  it 'given station zone set when require zone then return zone' do
    station.zone(test_zone)
    expect(station.station_zone).to eq test_zone
  end
end
