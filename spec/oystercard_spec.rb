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
  it 'given tapped out when tapping out then deduct penalty fare' do
    oystercard.top_up(10)
    oystercard.touch_out(exit_station)
    expect(oystercard.balance).to eq 4
  end

  context 'given a positive balance and touched in' do
    before(:each) do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
    end
    it 'then in journey' do
      expect(oystercard.in_journey?).to be true
    end
    it 'when touching in again then deduct penalty fare' do
      oystercard.touch_in(entry_station)
      expect(oystercard.balance).to eq 4
    end
    it 'when touching in again at new station then entry station is new station' do
      new_station = 'New Station'
      oystercard.touch_in(new_station)
      expect(oystercard.journey.entry_station).to eq new_station
    end
    context 'when touched out' do
      before(:each) do
        oystercard.touch_out(exit_station)
      end
      it 'then not in journey' do
        expect(oystercard.in_journey?).to be false
      end
      it 'then remembers journey' do
        expect(oystercard.journey_history).to eq [{ entry_station: entry_station, exit_station: exit_station }]
      end
      it 'then deduct minimum fare (1)' do
        expect(oystercard.balance).to eq 9
      end
      it 'given one complete journey and touched in when touching in then apply penalty fare (6)' do
        oystercard.touch_in(entry_station)
        oystercard.touch_in(entry_station)
        expect(oystercard.balance).to eq 3
      end
      it 'given one complete journey and touched out when touching out then apply penalty fare (6)' do
        oystercard.touch_out(entry_station)
        expect(oystercard.balance).to eq 3
      end
    end
  end
end
