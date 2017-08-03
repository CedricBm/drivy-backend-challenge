require "./json_utility"
require "test/unit"

class TestRental < Test::Unit::TestCase

  def test_read_file
    assert_equal("Hash", JSONUtility.read_file("data.json").class.name)
    assert_equal(nil, JSONUtility.read_file("nil.json"))
  end
end