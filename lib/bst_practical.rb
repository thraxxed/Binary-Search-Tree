require_relative "binary_search_tree"

def kth_largest(root, k)
  bst = BinarySearchTree.new(root)
  (k-1).times do
    curr = bst.maximum
    bst.erase(curr)
  end
  bst.maximum

end
