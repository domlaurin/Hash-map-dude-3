

require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable 
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.bucket(key).include?(key)
  end

  def set(key, val)
    unless self.include?(key)
      @count += 1
      if @count > self.num_buckets
        self.resize!
      end
      self.bucket(key).append(key, val)
    else
      self.bucket(key).each do |node|
        if node.key == key
          node.val = val
        end
      end
    end
  end
  
  def get(key)
    self.bucket(key).each do |node|
      if node.key == key
        return node.val
      end
    end
  end

  def delete(key)
    self.bucket(key).each do |node|
      if node.key == key
        node.remove
        @count -= 1
      end
    end
  end

  def each(&block)  #{|x| print x }
    @store.each do |ll|
      ll.each do |node|
        # debugger
        unless node.key == nil && node.val == nil
          block.call(node.key, node.val)
        end
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  # private

  def num_buckets
    @store.length
  end

  def resize!
    self.num_buckets.times do 
      @store << LinkedList.new
    end
    @store.each do |ll|
      ll.each do |node|
        self.delete(node.key)
        self.set(node.key, node.val)
      end
    end

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % self.num_buckets]
  end
end
