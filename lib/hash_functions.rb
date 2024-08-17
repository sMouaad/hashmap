# frozen_string_literal: true

# Module implementing operations on hash keys, such as turning keys into polynomial and computate it with horner
module HashFunctions
  def horner(polynomial, x = 128) # rubocop:disable Naming/MethodParameterName
    n = polynomial.length - 1
    value = polynomial[n]
    until n.zero?
      value = (value * x) + polynomial[n - 1]
      n -= 1
    end
    value
  end

  def key_to_polynomial(key)
    raise TypeError unless key.is_a? String

    key.chars.reverse.map(&:ord)
  end
end
