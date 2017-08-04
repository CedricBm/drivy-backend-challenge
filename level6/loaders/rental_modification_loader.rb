require_relative "../json_utility"
require_relative "../models/rental_modification"

class RentalModificationLoader

  def generate_rental_modifications_from_json_file(filename, rentals)
    rental_modifications = []
    input_hash = JSONUtility.read_file(filename)

    raise "There is no rental modification in the #{filename} file!" unless input_hash.key?("rental_modifications")

    input_hash["rental_modifications"].each do |rental_modification|
      rental = rentals.detect{|r| r.id == rental_modification["rental_id"]}
      rental = fetch_last_rental_modification_if_exists(rental, rental_modifications)

      unless rental == nil
        rental_modifications << compute_new_rental_modification(rental, rental_modification)
      end
    end

    rental_modifications
  end

  private

    # To be able to modify multiple times a rental, this method fetches the last created rental modification associated to a rental. If there is none, returns the original rental instead.
    # Params:
    # +rental+:: the original rental object
    # +rental_modifications+:: all rental modifications created until now
    def fetch_last_rental_modification_if_exists(rental, rental_modifications)
      last_rental = rental_modifications.select{|rental_modif| rental_modif.rental_id == rental.id}
                                        .sort{|x,y| y.id <=> x.id}
                                        .first

      last_rental == nil ? rental : last_rental
    end

    # Checks what rental attributes is modified and creates the new rental modification
    # Params:
    # +rental+:: the last [rental / rental modification] object associated to this new modification
    # +rental_modification+:: the json formatted rental modification
    def compute_new_rental_modification(rental, rental_modification)
      start_date = rental_modification.key?("start_date") ? rental_modification["start_date"] : rental.start_date.strftime(DATE_FORMAT)
      end_date = rental_modification.key?("end_date") ? rental_modification["end_date"] : rental.end_date.strftime(DATE_FORMAT)
      distance = rental_modification.key?("distance") ? rental_modification["distance"] : rental.distance

      RentalModification.new(rental_modification["id"], rental.car, start_date, end_date, distance, rental.deductible_reduction, rental_modification["rental_id"], rental)
    end

end