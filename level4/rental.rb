require "./commission"
require "./json_utility"
require "date"

class Rental
  attr_accessor :id, :car, :start_date, :end_date, :distance, :price, :commission, :has_deductible_reduction, :deductible_reduction

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
  end

  def self.generate_rentals_from_json_file(filename, cars)
    rentals = []
    input_hash = JSONUtility.read_file(filename)

    return rentals if input_hash == nil

    input_hash["rentals"].each do |rental|
      car = cars.detect{|c| c.id == rental["car_id"]}
      rentals << Rental.new(rental["id"], car, rental["start_date"], rental["end_date"], rental["distance"], rental["deductible_reduction"])
    end

    rentals
  end

  def calculate_price
    @price = 0

    for day_counter in 1..period_in_days
      @price += @car.price_per_day * decrease_price_rate(day_counter)
    end

    @price += @distance * @car.price_per_km
  end

  def period_in_days
    (@end_date - @start_date).to_i + 1 # Don't forget to add the first day
  end

  def decrease_price_rate(day_counter)
    if day_counter <= 1
      1
    elsif day_counter > 1 && day_counter <= 4
      0.9
    elsif day_counter > 4 && day_counter <= 10
      0.7
    else
      0.5
    end
  end

  def calculate_deductible_reduction
    @has_deductible_reduction ? period_in_days * 400 : 0
  end

  def calculate_commission
    commission_price = @price * 0.3

    insurance_fee = commission_price / 2
    assistance_fee = period_in_days * 100
    drivy_fee = commission_price - insurance_fee - assistance_fee

    Commission.new(insurance_fee, assistance_fee, drivy_fee)
  end

  def to_json
    {"id" => @id, "price" => @price.to_i, "options" => {"deductible_reduction" => @deductible_reduction}, "commission" => @commission.to_json}
  end

end