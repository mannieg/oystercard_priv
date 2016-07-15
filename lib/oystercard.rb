class Oystercard

  FARE = 1
  MAX_BALANCE = 90
  attr_reader :balance

  def initialize
    self.balance = 0
  end

  def top_up(amount)
    raise 'Over max balance' if over_max_balance?(amount)
    self.balance += amount
  end

  def touch_in
    raise 'Not enough balance for fare' if balance < FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct
  end

  def in_journey?
    @in_journey
  end

  private

  attr_writer :balance

  def over_max_balance?(amount)
    amount + balance > MAX_BALANCE
  end

  def deduct
    self.balance -= FARE
  end

end
