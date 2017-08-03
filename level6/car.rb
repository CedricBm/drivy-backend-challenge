require "./json_utility"

class Car
  attr_accessor :id, :price_per_day, :price_per_km

  def initialize(id, price_per_day, price_per_km)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  def self.generate_cars_from_json_file(filename)
    cars = []
    input_hash = JSONUtility.read_file(filename)

    return cars if input_hash == nil

    input_hash["cars"].each do |car|
      cars << Car.new(car["id"], car["price_per_day"], car["price_per_km"])
    end

    cars
  end

end