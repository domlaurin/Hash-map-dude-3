class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def include?(key)
    self[key].include?(key)
  end

  def insert(key)
    if @count >= self.num_buckets
      self.resize!
    end
    unless self.include?(key)
      self[key] << key
      @count += 1
    end
  end
  
  def remove(key)
     if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  # private

  def [](num)
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    self.num_buckets.times do 
      @store << []
    end
    @store.each do |bucket|
      bucket.each do |ele|
        if self.include?(ele)
          self[ele].delete(ele)
        end

        unless self.include?(ele)
          self[ele] << ele
        end
      end
    end

  end
end