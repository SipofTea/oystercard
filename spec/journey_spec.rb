require 'journey'

describe Journey do
  let(:journey) { Journey.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  context 'given entry station' do
    before(:each) do
      journey.start_journey(entry_station)
    end
    it 'when entering station then record entry station' do
      expect(journey.entry_station).to eq entry_station
    end

    context 'and given exit station' do
      before(:each) do
        journey.end_journey(exit_station)
      end
      it 'when exiting station then record exit station' do
        expect(journey.exit_station).to eq exit_station
      end
      it 'when exiting station then record current journey' do
        expect(journey.current_journey).to eq({ entry_station: entry_station, exit_station: exit_station })
      end
      it 'when exiting station then fare is miminum fair' do
        expect(journey.fare).to eq(Journey::MINIMUM_FARE)
      end
    end
  end
  it 'given entry station but no exit station when entering station then apply penalty' do
    journey.start_journey(entry_station)
    expect(journey.fare).to eq(Journey::PENALTY_FARE)
  end
  it 'given exit station but no entry station when exiting station then apply penalty' do
    journey.end_journey(exit_station)
    expect(journey.fare).to eq(Journey::PENALTY_FARE)
  end
end
