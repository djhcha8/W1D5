require_relative "00_tree_node.rb"
require "byebug"

class KnightPathFinder 

  def initialize(start_pos)
    @start = start_pos 
    @board = Array.new(8) {Array.new(8)}
    @visited_pos = [start_pos.dup]
  end 
  
  GENERATE = [-1,-2,1,2].permutation(2).to_a.select {|el| el.first.abs != el.last.abs}
  
  def [](pos)
    row, col = pos 
    @board[row][col]
  end 
  
  def []=(pos, mark)
    row, col = pos 
    @board[row][col] = mark
  end 
  
  def self.valid_moves(pos)
    valid = []
    GENERATE.each do |combi| 
      new_move = [pos.first + combi.first, pos.last + combi.last]
      valid << new_move unless new_move.any? { |el| el < 0 || el > 7 }
    end 
    valid
  end 
  
  # def generate_moves
  #   outcome = 
  #   outcome
  # end 
  
  def new_move_pos(pos)
    all_possible_moves = KnightPathFinder.valid_moves(pos)
    all_possible_moves = all_possible_moves.reject {|pot_moves| @visited_pos.include?(pot_moves)}
    @visited_pos += all_possible_moves
    all_possible_moves
  end 
  
  def build_move_tree
    # debugger
    queue = [PolyTreeNode.new(@start)] 
    result = [] 
    until queue.empty? 
      current_node = queue.shift 
      self.new_move_pos(current_node.value).each do |pos|
        child = PolyTreeNode.new(pos)
        child.parent = current_node
        queue << child 
      end 
      result << current_node 
    end 
    @move_tree = result
  end 

  def find_path(end_pos)
    queue = [@move_tree.first]
  
    until queue.empty?
      current = queue.shift
      return trace_path_back(current) if current.value == end_pos
      queue += current.children
    end
    
    raise "Cannot get there. Try different position!"
    nil
  end
  
  def trace_path_back(node)
    # debugger
    queue = [node]
    answer = [node.value]
    
    while
      current = queue.shift
      if current.parent == nil
        break
      end
      answer << current.parent.value
      queue << current.parent
    end
    
    answer.reverse
  end
  
end 