require "./car"
require "./json_utility"
require "./rental"

def main
  cars = Car.generate_cars_from_json_file("data.json")
  rentals = Rental.generate_rentals_from_json_file("data.json", cars)

  JSONUtility.write_file({"rentals" => rentals.map(&:to_json)})
end

main