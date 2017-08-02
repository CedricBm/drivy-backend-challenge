require "date"
require "json"

def main
  input_data = read_json_to_hash("data.json")
  rental_prices = calculate_rental_prices(input_data)
  write_json_file(rental_prices)
end

def read_json_to_hash(filename)
  file = File.read(filename)
  JSON.parse(file)
end

def calculate_rental_prices(data)
  rental_prices = {}
  rental_prices["rentals"] = []

  data["rentals"].each do |rental|
    rental_car = data["cars"].detect{|car| car["id"] == rental["car_id"]}
    price = calculate_price(rental, rental_car).to_i

    rental_prices["rentals"] << {"id" => rental["id"], "price" => price}
  end

  rental_prices
end

def calculate_price(rental, rental_car)
  nb_days = period_in_days(rental)
  price = 0

  for counter in 1..nb_days
    price += rental_car["price_per_day"] * decrease_rate_by_day(counter)
  end

  price += rental["distance"] * rental_car["price_per_km"]
end

def period_in_days(rental)
  start_date = Date.parse(rental["start_date"])
  end_date = Date.parse(rental["end_date"])

  (end_date - start_date).to_i + 1 # Don't forget to add the first day
end

def decrease_rate_by_day(counter)
  if counter <= 1
    1
  elsif counter > 1 && counter <= 4
    0.9
  elsif counter > 4 && counter <= 10
    0.7
  else
    0.5
  end
end

def write_json_file(output_data)
  File.open("output.json", "w") do |file|
    file.write(JSON.pretty_generate(output_data))
  end
end

main