require 'pry'

class Parser
  attr_reader :upper, :lower, :size, :buckets
  
  def initialize(args)
    @lower = args[:lower]
    @upper = args[:upper]
    @size = args[:size]
  end
  
  # print printer-instruction according to provided user input
  def print_instruction
    splits = sliced_print_range
    range = parsed_command_of(splits)
    report(range)
  end
  
  private  
  
  # print the even and odd printing statement into console
  # @param print_statement String representing the printing instruction 
  def report(print_statement)
    puts(print_statement)
  end
  
  def sliced_print_range
   whole_range = (@lower..@upper).to_a
   whole_range.each_slice(@size).to_a
  end
  
  def parsed_range(splits)
    last_tuple = splits.pop
    body_of(splits)+head_of(last_tuple)
  end
  
  def parsed_command_of(slits)
    even_odd_half_of(slits).map{|t| parsed_range(t)}
  end
  
  def even_odd_half_of(splits)
    left = splits.select.with_index{|_,i| (i+1) % 2 == 1}
    right = splits.select.with_index{|_,i| (i+1) % 2 == 0}
    [left, right]
  end
  
  def body_of(splits)
    (splits.empty?) ? '' : partial_instruction_of(splits)
  end
  
  def partial_instruction_of(splits)
    splits.inject('') do |string, subrange| 
      "#{string}#{subrange.first.to_s}-#{subrange.last.to_s};" 
    end
  end
  
  def head_of(last_tuple)
    tmp = "#{last_tuple.first}"
    tmp += "-#{last_tuple.last.to_s}" if(last_tuple.count > 1)
    tmp   
  end

end