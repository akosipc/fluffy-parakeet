require 'pry'

Dir[File.join("./lib/schema/*.rb")].each {|f| require f }
Dir[File.join("./lib/services/*.rb")].each {|f| require f }
Dir[File.join("./lib/validators/*.rb")].each {|f| require f }
