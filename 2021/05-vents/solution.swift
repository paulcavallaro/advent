import Foundation

struct Point {
    var x = 0
    var y = 0
}

let input = try String(contentsOfFile: "./input.txt")
let lines = input.components(separatedBy: "\n").filter({l in !l.isEmpty})
var sparse_matrix: [Int:[Int:Int]] = [:] // sparse_matrix[x][y]
for var line in lines {
    line.removeAll(where: {c in c == " "})
    let points = line.components(separatedBy: "->")
    let start_l = points[0].components(separatedBy: ",").map({x in Int(x) ?? 0})
    let end_l = points[1].components(separatedBy: ",").map({x in Int(x) ?? 0})
    let start = Point(x: start_l[0], y: start_l[1])
    let end = Point(x: end_l[0], y: end_l[1])
    if start.x == end.x {
        let x = start.x
        let min_y = min(start.y, end.y)
        let max_y = max(start.y, end.y)
        for y in min_y...max_y {
            sparse_matrix[x, default: [:]][y, default: 0] += 1
        }
    } else if start.y == end.y {
        let y = start.y
        let min_x = min(start.x, end.x)
        let max_x = max(start.x, end.x)
        for x in min_x...max_x {
            sparse_matrix[x, default: [:]][y, default: 0] += 1
        }
    }
}
var count = 0
for (x, sparse_col) in sparse_matrix {
    for (y, val) in sparse_col {
        if val >= 2 {
            count += 1
        }
    }
}
print(count)

