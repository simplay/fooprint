require "rubygems"
require 'optparse'
require_relative 'src/parser.rb'

Version = "1.0.0"

user_args = {}
opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage example for printing two pages per sheet from starting from page 1 to page 28: \nruby fooprint.rb -l 1 -u 28 -s 2"
  opt.separator  ""

  opt.on("-l", "--lower LOWER", Integer, "number of first page") do |lower|
    user_args[:lower] = lower
  end
  opt.on("-u", "--upper UPPER", Integer, "number of last page") do |upper|
    user_args[:upper] = upper
  end
  
  opt.on("-s", "--size SIZE", Integer, "number of pages per sheet") do |size|
    user_args[:size] = size
  end
  
  opt.on_tail("-h", "--help", "Show this message") do
    puts opt
    exit
  end
  opt.on_tail("--version", "Show version") do
    puts "Fooprint v#{Version}"
    exit
  end

end
begin 
  opt_parser.parse!
  required_args = [:lower, :upper, :size]
  required_args.each do |arg|
    raise OptionParser::MissingArgument if user_args[arg].nil?
  end

rescue OptionParser::MissingArgument
  puts "Incorrect input argument(s) passed\n"
  puts opt_parser.help
  exit
end

Parser.new(user_args).print_instruction
