import itertools

def main():
  part_one()
  part_two()

def part_two():
  with open('input.txt', 'r') as in_file:
    print(sliding_window((int(line) for line in in_file)))

def part_one():
  with open('input.txt', 'r') as in_file:
    print(num_incrs((int(line) for line in in_file)))

def num_incrs(nums):
  prev = None
  num_incrs = 0
  for num in nums:
    if prev is not None and num > prev:
      num_incrs += 1
    prev = num
  return num_incrs

def sliding_window(nums):
  a, b, c = itertools.tee(nums, 3)
  triplets = zip(a, itertools.islice(b, 1, None), itertools.islice(c, 2, None))
  sums = (x[0] + x[1] + x[2] for x in triplets)
  return num_incrs(sums)

if __name__ == '__main__':
  main()
