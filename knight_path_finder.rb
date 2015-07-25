require_relative 'tree_node'
require 'byebug'

class KnightPathFinder
  DIRECTIONS = [-1, 1, -2, 2]

  def initialize(pos = [0,0])
    @starting_position = PolyTreeNode.new(pos)
    @visited_positions = [@starting_position]
  end

  def find_path(target)
    current_node = build_move_tree(target)
    path = []
    until current_node.parent.nil?
      path << current_node.value
      current_node = current_node.parent
    end
    path << current_node.value
    path.reverse
  end

  def build_move_tree(target)
    queue = [@starting_position]
    until queue.empty?
      node = queue.shift
      return node if node.value == target
      new_move_positions(node)
      queue += node.children
    end
  end

  def valid_move?(pos, node)
    return false unless in_range?(pos)
    return false if @visited_positions.any? {|point| point.value == pos}
    current_position = node.value.dup
    diff = [0,0]
    2.times { |i| diff[i] = current_position[i] - pos[i] }
    diff = diff.map { |el| el.magnitude }
    diff == [1,2] || diff == [2,1]
  end

  def in_range?(pos)
    pos.each { |el| return false if (el < 0 || el > 7)}
    true
  end

  def new_move_positions(node)
    move_val = [0,0]
    DIRECTIONS.each do |x|
      DIRECTIONS.each do |y|
        move_val[0] = node.value[0] + x
        move_val[1] = node.value[1] + y
        node.add_child(PolyTreeNode.new(move_val.dup)) if valid_move?(move_val, node)
      end
    end
    @visited_positions += node.children
  end
end
