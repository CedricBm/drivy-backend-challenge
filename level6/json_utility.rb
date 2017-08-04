require "json"

class JSONUtility

  def self.read_file(filename)
    begin
      file = File.read(filename)
      JSON.parse(file)
    rescue => e
      raise "#{filename} file does not exists!"
    end
  end

  def self.write_file(output_data, output_name = "output.json")
    File.open(output_name, "w") do |file|
      file.write(JSON.pretty_generate(output_data))
    end
  end

end