require "./car"
require "./rental"
require "test/unit"

class TestRental < Test::Unit::TestCase

  def test_price
    car = Car.new(1, 2000, 10)
    rental = Rental.new(1, car, "2015-07-3", "2015-07-14", 1000)

    assert_equal(27800, rental.price)
  end

  def test_commission
    car = Car.new(1, 2000, 10)
    rental = Rental.new(1, car, "2015-07-3", "2015-07-14", 1000)

    assert_equal(4170, rental.commission.insurance_fee)
    assert_equal(1200, rental.commission.assistance_fee)
    assert_equal(2970, rental.commission.drivy_fee)
  end

  def test_deductible_reduction
    car = Car.new(1, 2000, 10)
    rental_without_reduction = Rental.new(1, car, "2015-07-3", "2015-07-14", 1000, false)
    rental_with_reduction = Rental.new(2, car, "2015-07-3", "2015-07-14", 1000, true)

    assert_equal(0, rental_without_reduction.deductible_reduction)
    assert_equal(4800, rental_with_reduction.deductible_reduction)
  end

  def test_actions
    car = Car.new(1, 2000, 10)
    rental_without_reduction = Rental.new(1, car, "2015-03-31", "2015-04-01", 300, false)
    rental_with_reduction = Rental.new(2, car, "2015-07-3", "2015-07-14", 1000, true)

    assert_equal(6800, rental_without_reduction.driver.amount)
    assert_equal(4760, rental_without_reduction.owner.amount)
    assert_equal(820, rental_without_reduction.drivy.amount)

    assert_equal(32600, rental_with_reduction.driver.amount)
    assert_equal(19460, rental_with_reduction.owner.amount)
    assert_equal(7770, rental_with_reduction.drivy.amount)
  end

end