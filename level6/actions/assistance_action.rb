class AssistanceAction < Action
  attr_accessor :who, :action_type, :amount

  def initialize(rental, action_type = "credit")
    amount = rental.commission.assistance_fee

    super("assistance", action_type, amount)
  end

end