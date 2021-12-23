import Foundation

class BingoBoard: CustomStringConvertible, NSCopying {
    var board : [Int]  = []
    init(board : [Int]) {
        self.board = board
    }

    func draw(_ needle : Int) {
        self.board = self.board.map(
          {n in if n == needle { return -1 } else { return n }})
    }

    func won() -> Bool {
        for row in 0..<5 {
            var won = true
            for col in 0..<5 {
                if self.board[row * 5 + col] != -1 {
                    won = false
                    break
                }
            }
            if won { return true }
        }
        for col in 0..<5 {
            var won = true
            for row in 0..<5 {
                if self.board[row * 5 + col] != -1 {
                    won = false
                    break
                }
            }
            if won { return true }
        }
        return false
    }

    func sum() -> Int {
        return self.board.filter({x in x != -1}).reduce(0, {x, y in x + y})
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = BingoBoard(board: self.board)
        return copy
    }

    var description: String {
        var str = "\nBingoBoard:\n"
        for row in 0..<5 {
            str += String(format: "%02d %02d %02d %02d %02d",
                          self.board[row * 5 + 0], self.board[row * 5 + 1],
                          self.board[row * 5 + 2], self.board[row * 5 + 3],
                          self.board[row * 5 + 4])
            if row < 4 {
                str += "\n"
            }
        }
        return str
    }
}

do {
    let input = try String(contentsOfFile: "./input.txt")
    let lines = input.components(separatedBy: "\n")
    let num_string = lines[0].components(separatedBy: ",")
    let draws = num_string.map{str in Int(str) ?? -1}

    var boards: [BingoBoard] = []
    var nums: [Int] = []
    for line in lines.dropFirst(1).filter({line in !line.isEmpty}) {
        let num_string = line.components(separatedBy: " ").filter(
          {str in !str.isEmpty})
        nums.append(contentsOf: num_string.map({str in Int(str) ?? -1}))
        if nums.count >= 25 {
            boards.append(BingoBoard(board: nums))
            nums = []
        }
    }
    let boards2 = boards.map({$0.copy() as! BingoBoard})
    part1(draws: draws, boards: boards)
    part2(draws: draws, boards: boards2)
}
catch {
}


func part1(draws: [Int], boards: [BingoBoard]) {
    for num in draws {
        for b in boards {
            b.draw(num)
            if b.won() {
                print(b)
                print("num = \(num), b.sum() = \(b.sum())")
                print("num * b.sum() = \(num * b.sum())")
                return
            }
        }
    }
}

func part2(draws: [Int], boards: [BingoBoard]) {
    var boards = boards
    var losers = boards.count
    for num in draws {
        for b in boards {
            b.draw(num)
            if b.won() {
                if losers == 1 {
                    print(b)
                    print("num = \(num), b.sum() = \(b.sum())")
                    print("num * b.sum() = \(num * b.sum())")
                    return
                } else {
                    losers -= 1
                }
            }
        }
        boards = boards.filter({b in !b.won()})
    }
}
