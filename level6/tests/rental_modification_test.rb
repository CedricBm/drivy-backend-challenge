require_relative "../models/car"
require_relative "../models/rental"
require_relative "../models/rental_modification"
require "test/unit"

class RentalModificationTest < Test::Unit::TestCase
  attr_reader :car, :rental, :rental_modification_one, :rental_modification_two

  def setup
    @car = Car.new(1, 2000, 10)
    @rental = Rental.new(1, car, "2015-07-3", "2015-07-14", 1000, true)
    @rental_modification_one = RentalModification.new(1, car, "2015-07-4", "2015-07-14", 1000, true, 1, rental)
    @rental_modification_two = RentalModification.new(1, car, "2015-07-4", "2015-07-14", 1300, true, 1, rental_modification_one)
  end

  def test_action_modifiers_after_one_modification
    assert_equal(1400, @rental_modification_one.action_modifications["driver"].amount)
    assert_equal(700, @rental_modification_one.action_modifications["owner"].amount)
    assert_equal(450, @rental_modification_one.action_modifications["drivy"].amount)
    assert_equal("credit", @rental_modification_one.action_modifications["driver"].action_type)
    assert_equal("debit", @rental_modification_one.action_modifications["owner"].action_type)
    assert_equal("debit", @rental_modification_one.action_modifications["drivy"].action_type)
  end

  def test_action_modifiers_after_two_modification
    assert_equal(3000, @rental_modification_two.action_modifications["driver"].amount)
    assert_equal(2100, @rental_modification_two.action_modifications["owner"].amount)
    assert_equal(450, @rental_modification_two.action_modifications["drivy"].amount)
    assert_equal("debit", @rental_modification_two.action_modifications["driver"].action_type)
    assert_equal("credit", @rental_modification_two.action_modifications["owner"].action_type)
    assert_equal("credit", @rental_modification_two.action_modifications["drivy"].action_type)
  end

end