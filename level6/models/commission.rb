class Commission
  attr_accessor :insurance_fee, :assistance_fee, :drivy_fee

  def initialize(insurance_fee, assistance_fee, drivy_fee)
    @insurance_fee = insurance_fee
    @assistance_fee = assistance_fee
    @drivy_fee = drivy_fee
  end

  def to_json
    {"insurance_fee" => @insurance_fee.to_i, "assistance_fee" => @assistance_fee.to_i, "drivy_fee" => @drivy_fee.to_i}
  end

end