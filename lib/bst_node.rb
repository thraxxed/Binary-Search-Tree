class BSTNode
  attr_accessor :value
  attr_accessor :left, :right
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end
