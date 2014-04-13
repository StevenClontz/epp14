module OverEasy

  def dictionary(length = nil)
    @prefixes = {}
    unless @dictionary
      @dictionary = IO.readlines("dictionary.txt")
      @dictionary.map! {|word| word.tr('J', 'I').chomp}
    end
    if length
      unless @prefixes[length]
        @prefixes[length] = @dictionary.map {|word| word[0...length]}.uniq
      else
        @prefixes[length]
      end
    else
      @dictionary
    end
  end

  class Coordinate
    attr_reader :x, :y
    def initialize(x_or_n, y=nil)
      unless y
        @x = x_or_n % 5
        @y = x_or_n / 5
      else
        @x = x_or_n
        @y = y
      end
    end

    def distance_from(other)
      (other.x-@x)**2 + (other.y-@y)**2
    end
  end

  # class Word
  #   attr_reader :letters
  #   def initialize(letters=[])
  #     @letters = letters
  #   end

  #   def push!(string, coordinate=nil)
  #     coordinate ||= Coordinate.new 0
  #     @letters << {str: string, coor: coordinate}
  #   end

  #   def to_s
  #     @letters.map {|h| h[:str]}.join
  #   end
  #   # alias_method :inspect, :to_s

  #   def is_in_dictionary?
  #     dictionary.include? to_s
  #   end

  #   def can_extend_to_dictionary?
  #     dictionary(to_s.size).include? to_s
  #   end

  #   def distances
  #     list = []
  #     (@letters.size-1).times do |n|
  #       list <<
  #         @letters[n][:coor].distance_from(@letters[n+1][:coor])
  #     end
  #     list
  #   end

  #   def has_increasing_distances?
  #     return true unless distances
  #     distances.uniq == distances.sort
  #   end

  #   def is_partial?
  #     can_extend_to_dictionary? && has_increasing_distances?
  #   end

  #   def is_valid?
  #     is_in_dictionary? && has_increasing_distances?
  #   end
  # end


  class Board
    attr_reader :table, :terms, :value
    def initialize(table)
      @table = table
      # puts "Created table for board:#{i}"
      @terms = []
      add_terms
      @terms.sort_by!{|t| t.size}.reverse!
      @value = 0
      @terms[0...25].each do |t|
        @value += t.size
      end
    end

    def self.random
      self.new [*('A'..'Z')].shuffle.reject {|j| j == 'J'}
    end

    def to_s
      to_s = "Board: \n"
      @table.each_slice(5) do |row|
        row.each do |cell|
          to_s << cell
        end
        to_s << "\n"
      end
      to_s
    end

    def get_coordinate_of(char)
      Coordinate.new @table.find_index(char)
    end

    
    def add_terms
      dictionary.each do |term|
        last_distance = -1
        fail = false
        (term.size-1).times do |n|
          start_coor = get_coordinate_of term[n]
          end_coor = get_coordinate_of term[n+1]
          check_distance = start_coor.distance_from(end_coor)
          if check_distance <= last_distance
            fail = true
          else
            last_distance = check_distance
          end
        end
        @terms << term unless fail
      end
    end
  end

  def puts_good_boards(start_board=Board.random)
    best_board = start_board
    puts best_board.to_s
    puts "#{best_board.table}"
    puts "#{best_board.terms[0...25]}"
    puts "Value: #{best_board.value}"
    10000000.times do
      # swap = (0...26).to_a.shuffle[0]
      # with = (0...26).to_a.shuffle[0]
      # swap_table = best_board.table
      # swap_table[swap] = best_board.table[with]
      # swap_table[with] = best_board.table[swap]
      # puts swap_table
      # b = Board.new swap_table
      b = Board.random
      if b.value > best_board.value
        best_board = b
        puts best_board.to_s
        puts "#{best_board.table}"
        puts "#{best_board.terms[0...25]}"
        puts "Value: #{best_board.value}"
      end
    end
  end

end