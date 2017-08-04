class DrivyAction < Action
  attr_accessor :who, :action_type, :amount

  def initialize(rental, action_type = "credit")
    amount = rental.commission.drivy_fee + rental.deductible_reduction

    super("drivy", action_type, amount)
  end

end