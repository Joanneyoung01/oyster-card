require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

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
    before(:all) do
      subject.top_up(Oystercard::MAX_BALANCE)

      let(:station){ double :station }
      it 'remembers the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

      it 'deducts money when you touch out' do
        expect { subject.touch_out(station) }.to change{ subject.balance }.by -Oystercard::MIN_CHARGE
      end

      describe 'lets you touch out' do
        specify { expect(subject.touch_out(station)).not_to be_truthy }
      end

     it 'lets you touch in' do
        specify { expect(subject.touch_in).to be_truthy }
      end
    end
  end

  context 'it has low or no balance' do
    before(:all) do
      subject.top_up(Oystercard::MIN_CHARGE)

      let(:journey) {{entry_station: entry_station, exit_station: exit_station}}
      it 'store the journey' do
        subject.touch_in('entry')
        subject.touch_out('exit')
        expect(subject.history).to include(:journey)
      end

      it 'throws an error if isufficient funds' do
        min_balance = Oystercard::MIN_CHARGE
        expect{ subject.touch_in }.to raise_error("Insufficient funds")
      end
    end
  end

  describe 'in_journey?' do
    specify { expect(subject.in_journey?).not_to be_truthy }
  end
end
