Dir.glob('actions/**/*.rb') { |f| require_relative f } # Requires every actors' action

# Decreased price_per_day rates when booking for many days
FULL_PRICE_RATE = 1
FIRST_DECREASE_PRICE_RATE = 0.9
SECOND_DECREASE_PRICE_RATE = 0.7
THIRD_DECREASE_PRICE_RATE = 0.5

# Decreased price_per_day thresholds
FULL_PRICE_THRESHOLD = 1
FIRST_DECREASE_PRICE_THRESHOLD = 4
SECOND_DECREASE_PRICE_THRESHOLD = 10

# Options and commissions
DEDUCTIBLE_REDUCTION_PRICE_PER_DAY = 400
COMMISSION_RATE = 0.3
INSURANCE_FEE_RATE = 0.5
ASSISTANCE_FEE_PRICE_PER_DAY = 100

DATE_FORMAT = "%Y-%m-%d"
ACTORS = {"driver" => DriverAction, "owner" => OwnerAction, "insurance" => InsuranceAction, "assistance" => AssistanceAction, "drivy" => DrivyAction}
