class InsuranceAction < Action
  attr_accessor :who, :action_type, :amount

  def initialize(rental, action_type = "credit")
    amount = rental.commission.insurance_fee

    super("insurance", action_type, amount)
  end

end