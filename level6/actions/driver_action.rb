class DriverAction < Action
  attr_accessor :who, :action_type, :amount

  def initialize(rental, action_type = "debit")
    amount = rental.price + rental.deductible_reduction

    super("driver", action_type, amount)
  end

end