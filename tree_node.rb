require 'set'

class PolyTreeNode
  attr_accessor :parent, :children, :value
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    return if @parent == node
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    @parent.children << self unless node.nil?
  end

  def add_child(child_node)
    return if @children.include?(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "Not yo kid brah" unless @children.include?(child)
    @children.delete(child)
    child.parent = nil
  end

  def dfs(target)
    return self if value == target
    children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target
      queue += node.children
    end
    nil
  end
end
