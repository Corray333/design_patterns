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
  for i in 2..n
    count += 1 if gcd(i, n) == 1
  end
  return count
end

print(coprime_count(10), "\n")

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

print(sum_of_digits_divisible_by_3(123456789), "\n")



# Метод 3. Найти делитель числа, являющийся взаимно простым с наибольшим количеством цифр данного числа.
def digits(num)
  digits = []
  while num!= 0
    digits.push num % 10
    num /= 10
  end
  digits
end

def have_divider(num, begin_of_range)
  while begin_of_range != 0
    num, begin_of_range = begin_of_range, num % begin_of_range
  end
  num
end

def max_coprime_divisor(num)
  max_count = 0
  result = 0
  (1..num).each do |i|
    if num % i == 0
      count = 0
      digits(num).each do |j|
        count += 1 if have_divider(i, j) == 1
      end
      if count >= max_count
        max_count = count
        result = i
      end
    end
  end
  result
end

print(max_coprime_divisor(1347), "\n")