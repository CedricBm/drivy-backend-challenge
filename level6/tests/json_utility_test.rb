require_relative "../json_utility"
require "test/unit"

class JSONUtilityTest < Test::Unit::TestCase

  def test_read_file
    assert_equal("Hash", JSONUtility.read_file("tests/data_test.json").class.name)

    exception = assert_raise {JSONUtility.read_file("nil.json")}
    assert_equal("nil.json file does not exists!", exception.message)
  end
end