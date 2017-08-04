require_relative "../loaders/car_loader"
require_relative "../loaders/rental_loader"
require "test/unit"

class RentalLoaderTest < Test::Unit::TestCase

  def test_generate_rentals_from_json_file
    cars = CarLoader.new.generate_cars_from_json_file("tests/data_test.json")
    rentals = RentalLoader.new.generate_rentals_from_json_file("tests/data_test.json", cars)

    assert_equal(3, rentals.length)
  end
end