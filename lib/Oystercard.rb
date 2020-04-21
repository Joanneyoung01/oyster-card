class Oystercard

  attr_reader :balance, :entry_station
  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "Upper limit of #{MAXIMUM_BALANCE} reached!" if value + @balance > MAXIMUM_BALANCE
   @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "Please top up" if balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out
    @balance -= MINIMUM_CHARGE
    @entry_station = nil
  end

end