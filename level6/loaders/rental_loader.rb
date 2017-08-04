require_relative "../json_utility"
require_relative "../models/rental"

class RentalLoader

  def generate_rentals_from_json_file(filename, cars)
    rentals = []
    input_hash = JSONUtility.read_file(filename)

    raise "There is no rental in the #{filename} file!" unless input_hash.key?("rentals")

    input_hash["rentals"].each do |rental|
      car = cars.detect{|c| c.id == rental["car_id"]}

      unless car == nil
        rentals << Rental.new(rental["id"], car, rental["start_date"], rental["end_date"], rental["distance"], rental["deductible_reduction"])
      end
    end

    rentals
  end

end