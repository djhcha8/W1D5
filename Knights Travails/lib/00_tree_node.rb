require "byebug"
class PolyTreeNode
  
  attr_accessor :children, :value
  attr_reader :parent
  
  def initialize(value)
    @children = []
    @parent = nil
    @value = value
  end
  
  def parent=(new_parent)
    
    if new_parent == nil 
      return @parent = nil 
    end 
    
    unless @parent == nil 
      @parent.children.delete(self)
    end 
    
    @parent = new_parent
    new_parent.children << self if new_parent.children.include?(self) == false
  
  end
  
  def add_child(new_child)
    new_child.parent = self
  end 
  
  def remove_child(old_child)
    raise "This is not a child of the current node you selected." unless self.children.include?(old_child)
    
    self.children.delete(old_child)
    
    old_child.parent = nil
  end 
  
  def dfs(target)
    return self if self.value == target
    
    self.children.each do |child_node|
      result = child_node.dfs(target)
      return result unless result.nil?
    end
    
    nil
  end
  
  def bfs(target)
    queue = [self]
    
    until queue.empty?
      current = queue.shift
      return current if current.value == target
      queue += current.children
    end
    
    nil
  end
end