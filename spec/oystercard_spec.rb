require 'Oystercard'

describe Oystercard do

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'tops up the card with money' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'can top up the balance' do
    expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
  end
  
  it 'has an upper limit' do
    limit = Oystercard::MAXIMUM_BALANCE
    subject.top_up(limit)

    expect { subject.top_up(5) }.to raise_error "Upper limit of #{limit} reached!"
  end

  it 'can deduct fare' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it 'should deduct fare from balance' do
    subject.top_up(10)
    expect(subject.deduct(5)). to eq 5
  end

  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
end