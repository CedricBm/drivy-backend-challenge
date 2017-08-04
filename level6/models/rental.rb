Dir.glob('../actions/**/*.rb') { |f| require_relative f } # Requires every actors' action
require_relative "../models/commission"
require_relative "../constants"
require_relative "../json_utility"
require "date"

class Rental
  attr_accessor :id, :car, :start_date, :end_date, :distance, :price, :commission, :has_deductible_reduction, :deductible_reduction, :actions

  def initialize(id, car, start_date, end_date, distance, has_deductible_reduction = false)
    @id = id
    @car = car
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @distance = distance
    @has_deductible_reduction = has_deductible_reduction

    @price = calculate_price
    @deductible_reduction = calculate_deductible_reduction
    @commission = calculate_commission
    generate_actions
  end

  def calculate_price
    @price = 0

    for day_counter in 1..period_in_days
      @price += @car.price_per_day * Rental.decrease_price_rate(day_counter)
    end

    @price += @distance * @car.price_per_km
  end

  def period_in_days
    (@end_date - @start_date).to_i + 1 # Don't forget to add the first day
  end

  def self.decrease_price_rate(day_counter)
    if day_counter <= FULL_PRICE_THRESHOLD
      FULL_PRICE_RATE
    elsif day_counter > FULL_PRICE_THRESHOLD && day_counter <= FIRST_DECREASE_PRICE_THRESHOLD
      FIRST_DECREASE_PRICE_RATE
    elsif day_counter > FIRST_DECREASE_PRICE_THRESHOLD && day_counter <= SECOND_DECREASE_PRICE_THRESHOLD
      SECOND_DECREASE_PRICE_RATE
    else
      THIRD_DECREASE_PRICE_RATE
    end
  end

  def calculate_deductible_reduction
    @has_deductible_reduction ? period_in_days * DEDUCTIBLE_REDUCTION_PRICE_PER_DAY : 0
  end

  def calculate_commission
    commission_price = @price * COMMISSION_RATE

    insurance_fee = commission_price * INSURANCE_FEE_RATE
    assistance_fee = period_in_days * ASSISTANCE_FEE_PRICE_PER_DAY
    drivy_fee = commission_price - insurance_fee - assistance_fee

    Commission.new(insurance_fee, assistance_fee, drivy_fee)
  end

  def generate_actions
    @actions = {}

    ACTORS.each do |actor_name, action_class|
      @actions[actor_name] = action_class.new(self)
    end
  end

  def to_json
    {"id" => @id, "actions" => @actions.values.map(&:to_json)}
  end

end