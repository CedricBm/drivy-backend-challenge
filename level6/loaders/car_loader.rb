require_relative "../json_utility"
require_relative "../models/car"

class CarLoader

  def generate_cars_from_json_file(filename)
    cars = []
    input_hash = JSONUtility.read_file(filename)

    raise "There is no car in the #{filename} file!" unless input_hash.key?("cars")

    input_hash["cars"].each do |car|
      cars << Car.new(car["id"], car["price_per_day"], car["price_per_km"])
    end

    cars
  end

end