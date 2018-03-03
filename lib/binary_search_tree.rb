require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize(root = nil)
    @root = root
  end

  def insert(value)
    unless @root
      @root = BSTNode.new(value)
    else
      current_node = @root
      while(current_node)
        if value < current_node.value
          unless current_node.left
            current_node.left = BSTNode.new(value)
            return
          end
          current_node = current_node.left
        else
          unless current_node.right
            current_node.right = BSTNode.new(value)
            return
          end
          current_node = current_node.right
        end
      end
    end
  end

  def find(value, tree_node = @root)
    while(tree_node)
      if value == tree_node.value
        return tree_node
      end
      if value <= tree_node.value
        tree_node = tree_node.left
      else
        tree_node = tree_node.right
      end
    end
  end

  def delete(value)
    node = find(value)
    erase(node)
  end

  # helper method for #delete:
  def erase(node)
    if node == @root
      erase_root(node)
      return
    end
    # NODE HAS NO CHILDREN
    if node.left.nil? && node.right.nil?
      erase_no_children(node)
      return
    end
    # NODE ONLY HAS LEFT CHILD
    if node.left && node.right.nil?
      erase_only_left(node)
      return
    end
    # NODE ONLY HAS RIGHT CHILD
    if node.right && node.left.nil?
      erase_only_right(node)
      return
    end
    # NODE HAS TWO CHILDREN
    erase_two_children(node)
  end

  def erase_root(node)
    if node.right.nil? && node.left
      @root = node.left
      return
    end
    if node.left.nil? && node.right
      @root = node.right
      return
    end
    if node.left.nil? && node.right.nil?
      @root = nil
      return
    end
    max = maximum(node.left)
    @root.value = max.value
    parent(max).right = max.left
    return
  end

  def erase_no_children(node)
    par = parent(node)
    if node.value <= par.value
      par.left = nil
      return
    end
    par.right = nil
  end

  def erase_only_left(node)
    par = parent(node)
    if node.value <= par.value
      par.left = node.left
      return
    end
    par.right = node.left
  end

  def erase_only_right(node)
    par = parent(node)
    if node.value <= par.value
      par.left = node.right
      return
    end
    par.right = node.right
  end

  def erase_two_children(node)
    max = maximum(node.left)
    node.value = max.value
    par = parent(max)
    par.right = max.left
  end

  def parent(node)
    tree_node = @root
    while true
      return tree_node if tree_node.left and tree_node.left == node
      return tree_node if tree_node.right == node
      if tree_node.left && node.value <= tree_node.value
        tree_node = tree_node.left
      else
        tree_node = tree_node.right
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    until tree_node.right.nil?
      tree_node = tree_node.right
    end
    return tree_node
  end

  def depth(tree_node = @root, prev = 0)
    return prev if tree_node.nil? or (tree_node.left.nil? and tree_node.right.nil?)
    return prev + 1 + [depth(tree_node.left, prev), depth(tree_node.right, prev)].max
  end

  def is_balanced?(tree_node = @root)
    left = tree_node.left
    right = tree_node.right
    unless left or right
      return true
    end
    depth_left = depth(left)
    depth_right = depth(right)
    return false unless (depth_left >= depth_right-1 and depth_left <= depth_right+1)
    if left and !right
      return is_balanced?(left)
    end
    if right and !left
      return is_balanced?(right)
    end
    is_balanced?(left) and is_balanced?(right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    if tree_node.left
      in_order_traversal(tree_node.left, arr)
    end
    arr << tree_node.value if tree_node
    if tree_node.right
      in_order_traversal(tree_node.right, arr)
    end
    arr
  end

end
