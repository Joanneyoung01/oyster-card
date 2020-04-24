require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }

  it 'has an empty hash' do
    expect(subject.history).to be_empty
  end

  it 'Has a initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'lets you top up card' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  it 'throws an error if maximum balance reached' do
    max_balance = Oystercard::MAX_BALANCE
    subject.top_up(max_balance)
    expect{ subject.top_up 1 }.to raise_error("Max balance reached: #{max_balance}")
  end

  context 'it has a balance' do
    before do
      subject.top_up(15)
    end

    let(:station){ double :station }
    it 'remembers the entry station' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'deducts money when you touch out' do
      expect { subject.touch_out(station) }.to change{ subject.balance }.by -Oystercard::MIN_CHARGE
    end

    describe 'lets you touch out' do
      specify { expect(subject.touch_out(station)).not_to be_falsey }
    end

    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    it 'stores exit station' do
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
    end

    describe 'lets you touch in' do
      specify { expect(subject.touch_in(station)).to be_truthy }
    end

    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    it 'stores a journey' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.history).to include journey
    end
    
  end

  context 'it has low or no balance' do
    let(:station){ double :station }
    it 'throws an error if isufficient funds' do
      expect{ subject.touch_in(station) }.to raise_error("Insufficient funds")
    end
  end

  describe 'in_journey?' do
    specify { expect(subject.in_journey?).to be_falsey }
  end
end
