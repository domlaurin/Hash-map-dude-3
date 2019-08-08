class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self.join.to_i.hash

    # hash_value = 0
    # self.each_with_index do |num, i|
    #   hash_value += num.hash * (i+1)
    # end
    # hash_value
  end
end

class String
  def hash
    self.unpack("B*")[0].split.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = []
    self.each do |k,v|
      array << [k.hash, v.hash]
    end
    array.sort.hash
  end
end
