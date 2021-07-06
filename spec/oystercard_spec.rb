require 'oystercard'

describe Oystercard do
    it {is_expected.to respond_to(:balance)}
    it 'given balance 0 when topping up then new balance is top up amount' do
        subject.top_up(10)
        expect(subject.balance).to eq 10
    end
    it 'given balance exceeds 90 when topping up then raise error' do
        expect{subject.top_up(100)}.to raise_error(RuntimeError)
    end
end