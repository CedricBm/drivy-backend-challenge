require "./main"
require "test/unit"

class TestRentals < Test::Unit::TestCase

  def test_read_json_to_hash
    input_data = read_json_to_hash("data.json")

    assert_equal(true, input_data.key?("cars"))
    assert_equal(true, input_data.key?("rentals"))

    assert_equal(1, input_data["cars"].length)
    assert_equal(3, input_data["rentals"].length)

    assert_equal(false, input_data.key?("trucks"))
  end

  def test_calculate_rental_prices
    input_data =
      {
        "cars" => [{"id" => 1, "price_per_day" => 2000, "price_per_km" => 10}],
        "rentals" => [{"id" => 1, "car_id" => 1, "start_date" => "2015-07-3", "end_date" => "2015-07-14", "distance" => 1000}]
      }
    rental_prices = calculate_rental_prices(input_data)

    assert_equal(1, rental_prices["rentals"].length)
    assert_equal(27800, rental_prices["rentals"].first["price"])
  end
end
