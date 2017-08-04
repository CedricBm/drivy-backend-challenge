# Run this file to run all tests at once
Dir[File.dirname(File.absolute_path(__FILE__)) + '/**/*_test.rb'].each {|file| require file }