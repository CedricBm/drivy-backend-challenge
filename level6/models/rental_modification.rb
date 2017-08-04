class RentalModification < Rental
  attr_accessor :rental_id, :rental, :action_modifications

  def initialize(id, car, start_date, end_date, distance, has_deductible_reduction, rental_id, rental)
    super(id, car, start_date, end_date, distance, has_deductible_reduction)

    @rental_id = rental_id
    @rental = rental
    generate_action_modifiers
  end

  def generate_action_modifiers
    @action_modifications = {}

    ACTORS.each do |actor_name, action_class|
      amount_difference = @actions[actor_name].amount - @rental.actions[actor_name].amount
      amount_difference *= -1 if actor_name == "driver" # the driver action type logic is reversed
      action_type = amount_difference > 0 ? "credit" : "debit"

      @action_modifications[actor_name] = Action.new(actor_name, action_type, amount_difference.abs)
    end
  end

  def to_json
    {"id" => @id, "rental_id" => @rental_id, "actions" => @action_modifications.values.map(&:to_json)}
  end

end