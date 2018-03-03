require_relative "binary_search_tree"

def kth_largest(root, k)
  bst = BinarySearchTree.new(root)
  until k == 1
    curr = bst.maximum
    bst.erase(curr)
    k -= 1
  end
  bst.maximum
end
