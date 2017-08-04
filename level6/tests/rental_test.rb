require_relative "../models/car"
require_relative "../models/rental"
require "test/unit"

class RentalTest < Test::Unit::TestCase
  attr_reader :car, :rental, :rental_with_reduction

  def setup
    @car = Car.new(1, 2000, 10)
    @rental = Rental.new(1, car, "2015-07-3", "2015-07-14", 1000, false)
    @rental_with_reduction = Rental.new(2, car, "2015-07-3", "2015-07-14", 1000, true)
  end

  def test_price
    assert_equal(27800, @rental.price)
  end

  def test_commission
    assert_equal(4170, @rental.commission.insurance_fee)
    assert_equal(1200, @rental.commission.assistance_fee)
    assert_equal(2970, @rental.commission.drivy_fee)
  end

  def test_deductible_reduction
    assert_equal(0, @rental.deductible_reduction)
    assert_equal(4800, @rental_with_reduction.deductible_reduction)
  end

  def test_actions
    assert_equal(27800, @rental.actions["driver"].amount)
    assert_equal(19460, @rental.actions["owner"].amount)
    assert_equal(2970, @rental.actions["drivy"].amount)

    assert_equal(32600, @rental_with_reduction.actions["driver"].amount)
    assert_equal(19460, @rental_with_reduction.actions["owner"].amount)
    assert_equal(7770, @rental_with_reduction.actions["drivy"].amount)
  end

end