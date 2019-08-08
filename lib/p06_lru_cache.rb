require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    unless @map.include?(key)
      val = @prc.call(key)
      @store.append(key, val)
      node = @store.tail.prev
      @map.set(key, node)
      if self.count > @max
        self.eject!
      end
      val
    else
      self.update_node!(key)
      @map.get(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  # private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    new_node = @store.append(key, val)
    @map[key] = new_node
    
  end

  def update_node!(key) #a/A used node instead of key
    val = @store.get(key)
    @store.remove(key)
    @store.append(key, val)
    @map.set(key, @store.last)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end

# hold max items
# when you retrieve or insert an item - mark it as now being most recently used item in your cache.
# when you insert an item - if the cache exceeds max, delete the least recently used item.

# we need a hash map and a linked list.
