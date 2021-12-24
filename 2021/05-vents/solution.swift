import Foundation

struct Point: Hashable {
    var x = 0
    var y = 0

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.x)
        hasher.combine(self.y)
    }
}

let input = try String(contentsOfFile: "./input.txt")
let lines = input.components(separatedBy: "\n").filter({l in !l.isEmpty})
var counts: [Point:Int] = [:]
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
            counts[Point(x:x, y:y), default: 0] += 1
        }
    } else if start.y == end.y {
        let y = start.y
        let min_x = min(start.x, end.x)
        let max_x = max(start.x, end.x)
        for x in min_x...max_x {
            counts[Point(x:x, y:y), default: 0] += 1
        }
    } else {
        // Diagonal lines, comment out for just part 1
        let (min_x_point, max_x_point) = start.x < end.x ?
          (start, end) : (end, start)
        // print("start: \(min_x_point) end: \(max_x_point)")
        let diff = max_x_point.y - min_x_point.y
        let y_range = stride(from:0, through:diff, by:(diff > 0 ? 1 : -1))
        for (x, dy) in zip(min_x_point.x ... max_x_point.x, y_range) {
            let y = min_x_point.y + dy
            // print("diagonal point: \(Point(x:x, y:y))")
            counts[Point(x:x, y:y), default: 0] += 1
        }
        // print("start: \(min_x_point) end: \(max_x_point)")
    }
}
var count = 0
for (_, val) in counts {
    if val >= 2 {
        count += 1
    }
}
print(count)

