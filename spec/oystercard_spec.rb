require 'oystercard'

describe Oystercard do
    let(:oystercard) { Oystercard.new }
    it {is_expected.to respond_to(:balance)}
    it 'given balance 0 when topping up then new balance is top up amount' do
        oystercard.top_up(10)
        expect(oystercard.balance).to eq 10
    end
    it 'given balance exceeds 90 when topping up then raise error' do
        expect{oystercard.top_up(100)}.to raise_error(RuntimeError)
    end
    it 'given balance 0 when deducting then the new balance is negative top up amount' do
        expect(oystercard.deduct(10)).to eq -10
    end

    context 'given a positive balance' do
        before(:each) do
            oystercard.top_up(10)
            oystercard.touch_in(oystercard.balance)
        end
        it 'given touched out when touching in then in journey' do
            expect(oystercard.in_use).to be true
            expect(oystercard.in_journey?).to be true
        end
        it 'given touched in when touching out then not in journey' do
            oystercard.touch_out
            expect(oystercard.in_use).to be false
            expect(oystercard.in_journey?).to be false
        end
    end

    it 'given touch in when below minimum balance then raise error' do
        expect{oystercard.touch_in(oystercard.balance)}.to raise_error(RuntimeError)
    end
end