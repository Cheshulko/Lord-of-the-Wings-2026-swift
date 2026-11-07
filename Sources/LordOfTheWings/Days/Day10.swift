/*
    It’s what happens when you run out of ideas and create such uninteresting problems.
*/
struct Day10: Solution {
    static let day = 10

    struct Point: Hashable {
        let i: Int
        let j: Int

        init(_ i: Int, _ j: Int) {
            self.i = i
            self.j = j
        }
    }

    let grid: [[Character]]
    let n: Int
    let m: Int
    let nullghost: [Point]

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
        nullghost = grid.enumerated().flatMap({ i, row in
            row.enumerated().compactMap({ j, cell -> Point? in
                switch cell {
                    case "<", "^", "v", ">": return Point(i, j)
                    default: return nil
                }
            })
        })
    }

    typealias Ghost = (point: Point, dir: Character, damage: Int)

    static let dirs: [Character: (di: Int, dj: Int)] = ["^": (-1, 0), ">": (0, 1), "v": (1, 0), "<": (0, -1)]
    static let clockwise: [Character: Character] = ["^": ">", ">": "v", "v": "<", "<": "^"]
    static let back: [Character: Character] = ["^": "v", "v": "^", "<": ">", ">": "<"]

    func step(_ ghosts: inout [Ghost], limit: Int = .max) {
        for k in ghosts.indices {
            let (di, dj) = Day10.dirs[ghosts[k].dir]!
            let to = Point(ghosts[k].point.i + di, ghosts[k].point.j + dj)
            if grid[to.i][to.j] == "#" {
                ghosts[k].dir = Day10.clockwise[ghosts[k].dir]!
                ghosts[k].damage += 1
            } else {
                ghosts[k].point = to
            }
        }
        ghosts.removeAll(where: { $0.damage >= limit })

        var count: [Point: Int] = [:]
        for ghost in ghosts {
            count[ghost.point, default: 0] += 1
        }
        for k in ghosts.indices where count[ghosts[k].point]! > 1 {
            ghosts[k].dir = Day10.back[ghosts[k].dir]!
            ghosts[k].damage += 1
        }
        ghosts.removeAll(where: { $0.damage >= limit })
    }

    func lastRound(limit: Int) -> Int {
        var ghosts: [Ghost] = nullghost.map({ (point: $0, dir: grid[$0.i][$0.j], damage: 0) })
        var round = 0
        var seen: [[Int]: (round: Int, damage: [Int])] = [:]
        while !ghosts.isEmpty {
            round += 1
            step(&ghosts, limit: limit)

            let key = ghosts.flatMap({ [$0.point.i, $0.point.j, Int($0.dir.asciiValue!)] })
            if let prev = seen[key] {
                let period = round - prev.round

                let skip = zip(ghosts, prev.damage).compactMap({ ghost, old -> Int? in
                    let gain = ghost.damage - old

                    return gain > 0 ? (limit - 1 - ghost.damage) / gain - 1 : nil
                }).min() ?? 0

                if skip > 0 {
                    for k in ghosts.indices {
                        ghosts[k].damage += skip * (ghosts[k].damage - prev.damage[k])
                    }
                    round += skip * period
                }
                seen = [:]
            }

            seen[key] = (round: round, damage: ghosts.map({ $0.damage }))
        }

        return round
    }

    func part1() throws -> any CustomStringConvertible {
        var ghosts = nullghost.map({ (point: $0, dir: grid[$0.i][$0.j], damage: 0) })
        for _ in 0..<10 {
            step(&ghosts)
        }

        return ghosts.map({ $0.damage }).reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        lastRound(limit: 10000)
    }

    func part3() throws -> any CustomStringConvertible {
        lastRound(limit: 1000000000000)
    }
}