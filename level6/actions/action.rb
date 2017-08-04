class Action
  attr_accessor :who, :action_type, :amount

  def initialize(who, action_type, amount)
    @who = who
    @action_type = action_type
    @amount = amount
  end

  def to_json
    {"who" => @who, "type" => @action_type, "amount" => @amount.to_i}
  end

end