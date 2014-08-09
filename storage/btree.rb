# Modify BinarySearchTree for `get_range` method

require 'binary_search_tree'
require 'binary_search_tree_hash'

class BinarySearchTree
  # Get array of keys between `key1` and `key2` starting from `node`
  def get_range(key1, key2, node)
    result = []
    if key2 < key1
      return result
    end
    if node.nil?
      return result
    end
    if key1 < node.key
      left_values = get_range(key1, key2, node.left)
      result.push(*left_values)
    end
    if key1 <= node.key && node.key <= key2
      result.push(node.key)
    end
    if node.key < key2
      result.push(*get_range(key1, key2, node.right))
    end
    result
  end
end

class BinarySearchTreeHash
  # Get array of keys between `key1` and `key2`
  def get_range(key1, key2)
    @bst.get_range(key1, key2, @bst.root)
  end
end