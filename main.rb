require_relative 'lib/hashmap'

test = HashMap.new
test.load_factor = 0.75
p test.entries
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('apple', 'green')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('elephant', 'blue')
p test.entries
p test.capacity

test.set('moon', 'silver')
p test.entries
p test.capacity
test.set('ice cream', 'pink')
p test.entries
p test.values
puts 'key is lion, value is ? : '
p test.get('lion')
p test.has?('lion')
p test.has?('lionness')
p test.has?('grape')
p test.entries
p test.remove('grape')
p test.entries
test.clear
p test.entries