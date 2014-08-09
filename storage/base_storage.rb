# Base class for storages of Key-Value database

class BaseStorage < Object
  def initialize(config)
    @config = config
    self.init!(config)
  end

  # Opens storage file on disk and reads data to RAM
  def init!(config)
    filename = config[:filename]
    File.open(filename, "r") do |infile|
      line = infile.gets
      # p line
      counter = 0
      while line
        puts "#{counter}: #{line}"
        self.store(line)
        counter = counter + 1
        line = infile.gets
      end
    end
  end

  # Store 1 line on RAM. Empty implementation
  # Params:
  # * line
  def store(line)
  end
end