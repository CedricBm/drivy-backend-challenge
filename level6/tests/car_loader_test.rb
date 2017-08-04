require_relative "../loaders/car_loader"
require "test/unit"

class CarLoaderTest < Test::Unit::TestCase

  def test_generate_cars_from_json_file
    cars = CarLoader.new.generate_cars_from_json_file("tests/data_test.json")

    assert_equal(1, cars.length)
  end
end