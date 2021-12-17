import statistics

def main():
  part_one()
  part_two()

def part_one():
  cols = None
  with open('input.txt', 'r') as in_file:
    cols = process1((line for line in in_file))
  modes = [statistics.mode(col) for col in cols]
  gamma = parse_binary(modes)
  epsilon = parse_binary(flip_bits(modes))
  print('gamma = {}, epsilon = {}'.format(gamma, epsilon))
  print('gamma * epsilon = {}'.format(gamma * epsilon))

def process1(lines):
  cols = None
  for line in lines:
    if not cols:
      cols = [[] for _ in line.strip()]
    for i, bit in enumerate(line.strip()):
      cols[i].append(int(bit))
  return cols

def part_two():
  with open('input.txt', 'r') as in_file:
    lines = [line for line in in_file]
    o2_rating = process(lines, oxygen=True)
    co2_rating = process(lines, oxygen=False)
  print('O2 rating = {}, CO2 rating = {}'.format(o2_rating, co2_rating))
  print('O2 * CO2 rating = {}'.format(o2_rating * co2_rating))

def process(lines, oxygen=True):
  nums = [[int(c) for c in line.strip()] for line in lines]
  num_cols = len(nums[0])
  for i in range(num_cols):
    bits = [num[i] for num in nums]
    if oxygen:
      mode = max(statistics.multimode(bits))
      nums = [x for x in nums if x[i] == mode]
    else:
      modes = statistics.multimode(bits)
      needle = 0 if len(modes) > 1 else 1 - modes[0]
      new_nums = [x for x in nums if x[i] == needle]
      if len(new_nums) > 0:
        nums = new_nums
  assert len(nums) == 1
  return parse_binary(nums[0])

def parse_binary(bits):
  x = 0
  exp = len(bits) - 1
  for b in bits:
    x += (2 ** exp) * b
    exp -= 1
  return x

def flip_bits(bits):
  return [1 - b for b in bits]

if __name__ == '__main__':
  main()
