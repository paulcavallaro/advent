def main():
  prev = None
  num_incrs = 0
  with open('input.txt', 'r') as in_file:
    for line in in_file:
      num = int(line)
      if prev is not None and num > prev:
        num_incrs += 1
      prev = num
  print(num_incrs)

if __name__ == '__main__':
  main()
