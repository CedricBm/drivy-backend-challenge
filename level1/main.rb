require "date"
require "json"

def main
  input_data = read_json_to_hash("data.json")
  rental_prices = generate_rental_prices(input_data)
  write_json_file(rental_prices)
end

def read_json_to_hash(filename)
  file = File.read(filename)
  JSON.parse(file)
end

def generate_rental_prices(data)
  rental_prices = {}
  rental_prices["rentals"] = []

  data["rentals"].each do |rental|
    start_date = Date.parse(rental["start_date"])
    end_date = Date.parse(rental["end_date"])
    nb_days = (end_date - start_date).to_i + 1 # Don't forget to add the first day

    rental_car = data["cars"].detect{|car| car["id"] == rental["car_id"]}
    price = nb_days * rental_car["price_per_day"] + rental["distance"] * rental_car["price_per_km"]

    rental_prices["rentals"] << {"id": rental["id"], "price": price}
  end

  rental_prices
end

def write_json_file(output_data)
  File.open("output.json", "w") do |file|
    file.write(JSON.pretty_generate(output_data))
  end
end

main