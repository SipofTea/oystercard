require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it { is_expected.to respond_to(:balance) }
  it 'given balance 0 when topping up then new balance is top up amount' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq 10
  end
  it 'given balance exceeds 90 when topping up then raise error' do
    expect { oystercard.top_up(100) }.to raise_error(RuntimeError)
  end
  it 'given balance below minimum when touch in then raise error' do
    expect { oystercard.touch_in(entry_station) }.to raise_error(RuntimeError)
  end
  it 'given never used when checking journey history then history is empty' do
    expect(oystercard.journey_history).to be_empty
  end

  context 'given a positive balance and touched in' do
    before(:each) do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
    end
    it 'then remember entry station' do
      expect(oystercard.entry_station).to eq entry_station
    end
    it 'then in journey' do
      expect(oystercard.in_journey?).to be true
    end

    context 'when touched out' do
      before(:each) do
        oystercard.touch_out(exit_station)
      end
      it 'then not in journey' do
        expect(oystercard.in_journey?).to be false
      end
      it 'then entry station is nil' do
        expect(oystercard.entry_station).to be_nil
      end
      it 'then deduct min fare' do
        expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-Oystercard::MIN_BALANCE)
      end
      it 'then remember exit station' do
        expect(oystercard.exit_station).to eq exit_station
      end
      it 'then remembers journey' do
        expect(oystercard.journey_history).to eq [{ entry_station: entry_station, exit_station: exit_station }]
      end
    end
  end
end

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
