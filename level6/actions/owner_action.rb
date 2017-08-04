class OwnerAction < Action
  attr_accessor :who, :action_type, :amount

  def initialize(rental, action_type = "credit")
    amount = rental.price * (1 - COMMISSION_RATE)

    super("owner", action_type, amount)
  end

end