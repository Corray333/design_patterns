# Variant 2
# Метод 1. Найти количество чисел, взаимно простых с заданным.
def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  return a
end

def coprime_count(n)
  count = 0
  for i in 1..n
    count += 1 if gcd(i, n) == 1
  end
  return count
end

print coprime_count(10), "\n"

# Метод 2. Найти сумму цифр числа, делящихся на 3.
def sum_of_digits_divisible_by_3(n)
  sum = 0
  while n > 0
    digit = n % 10
    sum += digit if digit % 3 == 0
    n /= 10
  end
  return sum
end

# Метод 3. Найти делитель числа, являющийся взаимно простым с наибольшим количеством цифр данного числа.
def max_coprime_divisor(n)
  divisor = 1
  max_coprime_count = 0

  num_length = 0
  temp = n
  while temp > 0
    num_length += 1
    temp /= 10
  end

  for i in 2..n
    coprime_count = 0
    temp = n

    while temp > 0
      digit = temp % 10
      if gcd(digit, i) == 1
        coprime_count += 1 
      end
      temp /= 10
    end
        
    if coprime_count > max_coprime_count
      max_coprime_count = coprime_count
      divisor = i
      
      if max_coprime_count == num_length
        return divisor
      end
    end
  end
  return divisor
end

print max_coprime_divisor(1347), "\n"