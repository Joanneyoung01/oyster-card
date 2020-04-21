class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(value)
    raise "Upper limit of #{MAXIMUM_BALANCE} reached!" if value + @balance > MAXIMUM_BALANCE
   @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @journey_status
  end

  def touch_in
    @journey_status = true
  end

  def touch_out
    @journey_status = false
  end

end