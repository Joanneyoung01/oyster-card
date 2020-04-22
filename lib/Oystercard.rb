class Oystercard

  MIN_CHARGE = 1
  MAX_BALANCE = 90
  attr_reader :balance, :entry_station, :history
  attr_accessor :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @history = {}
  end

  def top_up(amount)
    fail "Max balance reached: #{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MIN_CHARGE
    @entry_station = station
  end

  def in_journey?
    !!entry_station
  end

  def touch_out(station)
    deduct
    @entry_station = nil
    @exit_station = station
    store_journey
    @exit_station = nil
  end

  def store_journey
    @history[entry_station] = exit_station
  end

  private

  def deduct(amount=MIN_CHARGE)
    @balance -= amount
  end

end
