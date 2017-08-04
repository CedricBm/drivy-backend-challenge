require_relative "../loaders/car_loader"
require_relative "../loaders/rental_loader"
require_relative "../loaders/rental_modification_loader"
require "test/unit"

class RentalModificationLoaderTest < Test::Unit::TestCase

  def test_generate_rentals_from_json_file
    cars = CarLoader.new.generate_cars_from_json_file("tests/data_test.json")
    rentals = RentalLoader.new.generate_rentals_from_json_file("tests/data_test.json", cars)
    rental_modifications = RentalModificationLoader.new.generate_rental_modifications_from_json_file("tests/data_test.json", rentals)

    last_rental_modification = rental_modifications.detect{|rm| rm.id == 3}

    assert_equal(3, rental_modifications.length)
    assert_equal(2, last_rental_modification.rental.id)
    assert_equal("RentalModification", last_rental_modification.rental.class.name)
  end
end