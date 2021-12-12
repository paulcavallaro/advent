import statistics

def main():
  part_one()

def part_one():
  cols = None
  with open('input.txt', 'r') as in_file:
    cols = process((line for line in in_file))
  modes = [statistics.mode(col) for col in cols]
  gamma = parse_binary(modes)
  epsilon = parse_binary(flip_bits(modes))
  print('gamma = {}, epsilon = {}'.format(gamma, epsilon))
  print('gamma * epsilon = {}'.format(gamma * epsilon))

def process(lines):
  cols = None
  for line in lines:
    if not cols:
      cols = [[] for _ in line.strip()]
    for i, bit in enumerate(line.strip()):
      cols[i].append(int(bit))
  return cols

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
