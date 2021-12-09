def main():
  part_one()
  part_two()

def part_two():
  with open('input.txt', 'r') as in_file:
    pos, aim = process2((line for line in in_file))
    print('pos: {}, aim: {}'.format(pos,aim))
    (x, y) = pos
    print(x * y)

def process2(lines):
  pos = (0,0)
  aim = 0
  for line in lines:
    pos, aim = update2(pos, aim, line)
  return pos, aim

def update2(pos, aim, line):
  # (x, y) describes a position where x is horizontal position, and y is 'depth'
  # with the axis pointing downward, i.e., (2, 3) represents a submarine at
  # horizontal position 2 with depth 3.
  #
  # (2, 3) 4 || down 3     => (2, 3) 7
  # (2, 3) 4 || up 3       => (2, 3) 1
  # (2, 3) 4 || forward 3  => (5, 15) 4
  (x, y) = pos
  if line.startswith('forward '):
    m = int(line[8:])
    return (x + m, y + (m * aim)), aim
  if line.startswith('down '):
    return (x, y), aim + int(line[5:])
  if line.startswith('up '):
    return (x, y), aim - int(line[3:])
  raise Exception('Unexpected command: {}'.format(line))

def part_one():
  with open('input.txt', 'r') as in_file:
    pos = process1((line for line in in_file))
    print(pos)
    (x, y) = pos
    print(x * y)

def process1(lines):
  pos = (0,0)
  for line in lines:
    pos = update1(pos, line)
  return pos

def update1(pos, line):
  # (x, y) describes a position where x is horizontal position, and y is 'depth'
  # with the axis pointing downward, i.e., (2, 3) represents a submarine at
  # horizontal position 2 with depth 3.
  #
  # (2, 3) || down 3 => (2, 6)
  (x, y) = pos
  if line.startswith('forward '):
    return (x + int(line[8:]), y)
  if line.startswith('down '):
    return (x, y + int(line[5:]))
  if line.startswith('up '):
    return (x, y - int(line[3:]))
  raise Exception('Unexpected command: {}'.format(line))

if __name__ == '__main__':
  main()
