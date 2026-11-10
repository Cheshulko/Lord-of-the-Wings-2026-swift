struct Day11: Solution {
    static let day = 11

    let n: Int
    let shortcuts: [(Int, Int)]

    init(input: String) {
        let split = input.split(separator: "\n\n")
        
        n = Int(split[0].split(whereSeparator: \.isWhitespace)[1])!
        shortcuts = split[1].split(separator: "\n").map({ line -> (Int, Int) in 
            let split = line.split(whereSeparator: \.isWhitespace)

            return (Int(split[0])! - 1, Int(split[1])! - 1)
        })
    }

    func floydWarshall(_ grid: inout [[Int]]) {
        for k in 0..<n {
            for i in 0..<n {
                for j in 0..<n {
                    if grid[i][k] == .max || grid[k][j] == .max {
                        continue
                    }

                    grid[i][j] = min(grid[i][j], grid[i][k] + grid[k][j])
                }
            }
        }
    }

    func add(_ u: Int, _ v: Int, to grid: [[Int]]) -> [[Int]] {
        var next = grid
        for i in 0..<n {
            for j in 0..<n {
                next[i][j] = min(grid[i][j], 
                    grid[i][u] + 1 + grid[v][j], 
                    grid[i][v] + 1 + grid[u][j]
                )
            }
        }

        return next
    }

    func part1() throws -> any CustomStringConvertible {
        var grid = Array(repeating: Array(repeating: Int.max, count: n), count: n)
        for i in 0..<n {
            grid[i][i] = 0
            grid[i][(n + i - 1) % n] = 1
            grid[i][(i + 1) % n] = 1
        }

        floydWarshall(&grid)

        let before = (0..<n).map({ grid[$0].reduce(0, +) }).reduce(0, +)

        for (a, b) in shortcuts {
            grid[a][b] = 1
            grid[b][a] = 1
        }

        floydWarshall(&grid)
        
        let after = (0..<n).map({ grid[$0].reduce(0, +) }).reduce(0, +)
        
        return before - after
    }

    func part2() throws -> any CustomStringConvertible {
        var grid = Array(repeating: Array(repeating: Int.max, count: n), count: n)
        assert(n > 3)
        for i in 0..<n {
            grid[i][i] = 0
            for d in 1...3 {
                grid[i][(n + i - d) % n] = 1
                grid[i][(i + d) % n] = 1
            }
        }

        floydWarshall(&grid)

        let before = (0..<n).map({ grid[$0].reduce(0, +) }).reduce(0, +)

        for (a, b) in shortcuts {
            grid = add(a, b, to: grid)
        }

        var best = before
        for i in 0..<n {
            for j in i + 1..<n {
                if grid[i][j] == 1 {
                    continue
                }

                let grid_local = add(i, j, to: grid)
                let after = (0..<n).map({ grid_local[$0].reduce(0, +) }).reduce(0, +)

                best = min(best, after)
            } 
        }
        
        return before - best
    }

    func part3() throws -> any CustomStringConvertible {
        var grid = Array(repeating: Array(repeating: Int.max, count: n), count: n)
        assert(n > 3)
        for i in 0..<n {
            grid[i][i] = 0
            for d in 1...3 {
                grid[i][(n + i - d) % n] = 1
                grid[i][(i + d) % n] = 1
            }
        }

        floydWarshall(&grid)

        let before = (0..<n).map({ grid[$0].reduce(0, +) }).reduce(0, +)

        for (a, b) in shortcuts {
            grid[a][b] = 1
            grid[b][a] = 1
        }

        floydWarshall(&grid)

        var best = before
        func pair(_ crystals: [Int], grid: [[Int]]) {
            guard let first = crystals.first else {
                best = min(best, (0..<n).map({ grid[$0].reduce(0, +) }).reduce(0, +))
                return
            }

            for k in 1..<crystals.count {
                var rest = crystals
                rest.remove(at: k)
                rest.removeFirst()
                pair(rest, grid: add(first, crystals[k], to: grid))
            }
        }

        // 8 crystals
        // "the crystals had to be spread at perfectly equal intervals around the entire ring"
        precondition(n % 8 == 0)
        let gap = n / 8
        for start in 0..<gap {
            pair((0..<8).map({ start + $0 * gap }), grid: grid)
        }

        return before - best
    }
}