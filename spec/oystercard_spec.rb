require 'oystercard'

describe Oystercard do
    let(:oystercard) { Oystercard.new }
    let(:station) { double :station}

    it {is_expected.to respond_to(:balance)}
    it 'given balance 0 when topping up then new balance is top up amount' do
        oystercard.top_up(10)
        expect(oystercard.balance).to eq 10
    end
    it 'given balance exceeds 90 when topping up then raise error' do
        expect{oystercard.top_up(100)}.to raise_error(RuntimeError)
    end

    context 'given a positive balance' do
        before(:each) do
            oystercard.top_up(10)
            oystercard.touch_in('South Norwood')
        end
        it 'given touched out when touching in then in journey' do
            expect(oystercard.in_journey?).to be true
        end
        it 'given touched in when touching out then not in journey' do
            oystercard.touch_out
            expect(oystercard.in_journey?).to be false
        end
        it 'given entry station not nil when touched in then in journey' do
            oystercard.touch_in('South Norwood')
            expect(oystercard.in_journey?).to eq true
        end
        it 'given touched out entry station is then nil' do
            oystercard.touch_out
            expect(oystercard.in_journey?).to eq false
        end
        it 'given touched in when touching out then deduct min fare' do
            expect {oystercard.touch_out}.to change{oystercard.balance}.by(-Oystercard::MIN_BALANCE)
        end
        it 'when touch in then remember entry station' do
            expect(oystercard.entry_station).to eq 'South Norwood'
        end
        it 'when touch out then forgets entry station' do
            oystercard.touch_out
            expect(oystercard.entry_station).to be_nil
        end
    end
    it 'given touch in when below minimum balance then raise error' do
        expect{oystercard.touch_in(oystercard.balance)}.to raise_error(RuntimeError)
    end
end 