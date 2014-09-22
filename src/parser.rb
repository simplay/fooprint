require 'pry'

# A Parser forms two printing instructions for printing a certain page range [:lower, :upper]
# of a file when defining a certain number of pages per sheet [:size].
#
# Parser#print_instruction prints the two corresponding print statements into the terminal.
#
class Parser
  attr_reader :upper, :lower, :size

  # @param args [Hash] which contains the following keys
  #        :lower [Integer] indicating the starting page to print
  #        :upper [Integer] indicating the last page to print
  #        :size [Integer] indicating the number of pages per sheet page.
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
  # @param print_statement [String] representing the printing instruction
  def report(print_statement)
    puts(print_statement)
  end

  # Collect all even and all odd slit-subranges from given :slits
  # @param slits [Array] collection of sub-ranges
  #        of range between :lower and :upper-pdf
  #        of length :size
  # @return [Array] collection of even and odd :slits
  def parsed_command_of(slits)
    even_odd_half_of(slits).map{|t| parsed_range(t)}
  end

  # Split a given range from :lower to :upper into
  # a collection of subranges of size :size
  # @return [Array] subrange called 'splits' of
  #         step-size :size of range [:lower, :upper]
  def sliced_print_range
   whole_range = (@lower..@upper).to_a
   whole_range.each_slice(@size).to_a
  end

  # Split given partial ranges into even and odd print jobs
  # @param splits [Array] collection of pages per sheet.
  def even_odd_half_of(splits)
    odd = splits.select.with_index{|_,i| (i+1) % 2 == 1}
    even = splits.select.with_index{|_,i| (i+1) % 2 == 0}
    # necessary to reverse order of 2nd half
    # otherwise someone would have to manually reverse
    # all the printed pages after having printed
    # the first half of the document.
    even.reverse!
    [odd, even]
  end

  # Get stringified printer/instruction for splits
  # @param splits [Array] collection of pages per sheet.
  # @return [String] printer-instruction for last tuple of slits
  def parsed_range(splits)
    last_tuple = splits.pop
    body_of(splits) + head_of(last_tuple)
  end

  # Get stringified printer/instruction for last split :last_tuple in splits
  # @param last_tuple [Array] last split of splits
  # @return [String] printer-instruction for last tuple of slits
  def head_of(last_tuple)
    tmp = "#{last_tuple.first}"
    tmp += "-#{last_tuple.last}" if(last_tuple.count > 1)
    tmp   
  end

  # Get stringified printer/instruction for given splits
  # @param splits [Array] collection of pages per sheet without head
  # @return [String] printer-instruction for last tuple of slits
  #                  or '' if splits is empty
  def body_of(splits)
    (splits.empty?) ? '' : partial_instruction_of(splits)
  end

  # proceeds slits like they were head elements relying on Parser#head_of
  # @param splits [Array] collection of pages per sheet without head
  # @return [String] printer-instruction for last tuple of slits
  def partial_instruction_of(splits)
    splits.inject('') do |string, sub_range|
      "#{string}#{head_of(sub_range)};"
    end
  end

end