import Collections

struct Day18: Solution {
    static let day = 18

    let segments: [(x: Int, y: Int, width: Int)]

    init(input: String) {
        segments = input.lines.map({ line in
            let split = line.split(whereSeparator: \.isWhitespace)
            let x = Int(split[0].dropFirst(2))!
            let y = Int(split[1].dropFirst(2))!

            let width = split.count > 2 ? Int(split[2].dropFirst(6))! : 1

            return (x: x, y: y, width: width)
        })
    }

    func part1() throws -> any CustomStringConvertible {
        let levels =  segments.flatMap({ s in (0..<s.width).map({ (x: s.x + $0, y: s.y) }) })
        let n = levels.count

        var suffix_max = Array(0..<n)
        for k in (0..<n - 1).reversed() {
            if levels[suffix_max[k + 1]].y > levels[k].y {
                suffix_max[k] = suffix_max[k + 1]
            }
        }

        var i = 0
        var ans = 0
        while i < n - 1 {
            if levels[suffix_max[i + 1]].y >= levels[i].y {
                let next = levels[(i + 1)...].firstIndex(where: { $0.y >= levels[i].y })!
                ans += (levels[next].x - levels[i].x) * levels[i].y
                for j in i..<next {
                    ans -= levels[j].y
                }
                i = next
            } else {
                let max = suffix_max[i + 1]
                ans += (levels[max].x - levels[i].x) * levels[max].y
                for j in (i + 1)...max {
                    ans -= levels[j].y
                }
                i = max
            }
        }

        return ans + levels.map({ $0.y }).reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        try part1()
    }

    func part3() throws -> any CustomStringConvertible {
        try part1()
    }
}