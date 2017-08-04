require_relative "loaders/car_loader"
require_relative "loaders/rental_loader"
require_relative "loaders/rental_modification_loader"
require_relative "json_utility"

def main
  input_file_path = ARGV[0]
  unless ARGV.reject{|arg| arg == ""}.length == 1
    raise "Error: USAGE ruby main.rb json_file"
  end

  cars = CarLoader.new.generate_cars_from_json_file(input_file_path)
  rentals = RentalLoader.new.generate_rentals_from_json_file(input_file_path, cars)
  rental_modifications = RentalModificationLoader.new.generate_rental_modifications_from_json_file(input_file_path, rentals)

  JSONUtility.write_file({"rental_modifications" => rental_modifications.map(&:to_json)})
end

main