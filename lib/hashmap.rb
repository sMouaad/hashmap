# frozen_string_literal: true

require_relative 'hash_functions'
require_relative 'linkedlist/linked_list'
# Hashmap class
class HashMap
  attr_accessor :load_factor

  CONSTANT_A = (Math.sqrt(5) - 1) / 2
  INITIAL_CAPACITY = 16
  include HashFunctions
  def initialize
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
    @load_factor = 0.8
  end

  # Hashing using multiplication method
  def hash(key)
    if key.is_a? String
      key = horner(key_to_polynomial(key))
      (capacity * ((key * CONSTANT_A) % 1)).floor
    else
      raise IndexError if key.negative? || key >= capacity

      key
    end
  end

  def set(key, value)
    if has?(key)
      @buckets[hash(key)].override(key, value)
    else
      @buckets[hash(key)].append([[key, value]])
    end
    # Adding more capacity if current load surpasses the load factor
    return [key, value] unless (length.to_f / (buckets_length = capacity)) > (@load_factor)

    # Reallocating everything
    hash_entries = entries
    @buckets = Array.new(buckets_length * 2) { LinkedList.new }
    puts 'FOUAD FOUAD'
    p capacity
    hash_entries.each { |bucket| bucket.each { |keyvalue| @buckets[hash(keyvalue[0])].append([keyvalue]) } }
  end

  def get(key)
    @buckets[hash(key)].find_value(key)
  end

  def get_bucket_values(bucket)
    get_bucket_entries(bucket).map(&:last)
  end

  def get_bucket_keys(bucket)
    get_bucket_entries(bucket).map(&:first)
  end

  def get_bucket_entries(bucket)
    bucket.to_a
  end

  def length
    keys.length
  end

  def capacity
    @buckets.length
  end

  def clear
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
  end

  def keys
    @buckets.filter_map { |bucket| get_bucket_keys(bucket) unless bucket.empty? }.flatten
  end

  def values
    @buckets.filter_map { |bucket| get_bucket_values(bucket) unless bucket.empty? }.flatten
  end

  def entries
    @buckets.filter_map { |bucket| get_bucket_entries(bucket) unless bucket.empty? }
  end

  # Could've used #keys method but it's less optimal because of higher space and time complexity
  # We iterate one bucket looking for the key if the hashed key (index) is not nil
  # If we found the key, we return true, else, we return false
  def has?(key)
    return false if (@buckets[hashed_key = hash(key)]).empty? # O(1) complexity best case scenario

    # Possibility of collision, so we check if the key exists
    # Worst-case time-complexity is O(n) with n being the number of elements in the linked list
    return true if get_bucket_keys((@buckets[hashed_key])).any?(key)

    # Key not found despite hashed key index is not nil, means presence of a collision
    false
  end

  def remove(key)
    return nil unless has?(key)

    @buckets[hash(key)].remove_key(key)
  end
end
