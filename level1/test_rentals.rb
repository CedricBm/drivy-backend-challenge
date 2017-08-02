require "./main"
require "test/unit"

class TestRentals < Test::Unit::TestCase

  def test_read_json_to_hash
    input_data = read_json_to_hash("data.json")

    assert_equal(true, input_data.key?("cars"))
    assert_equal(true, input_data.key?("rentals"))

    assert_equal(3, input_data["cars"].length)
    assert_equal(3, input_data["rentals"].length)

    assert_equal(false, input_data.key?("trucks"))
  end

  def test_generate_rental_prices
    input_data = read_json_to_hash("data.json")
    rental_prices = generate_rental_prices(input_data)

    assert_equal(true, rental_prices.key?("rentals"))
    assert_equal(3, rental_prices["rentals"].length)
    assert_equal(11250, rental_prices["rentals"].last[:price])
  end
end
