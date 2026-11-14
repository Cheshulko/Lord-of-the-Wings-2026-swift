import Collections

struct Day15: Solution {
    static let day = 15

    let grid: [[Character]]
    let n: Int
    let m: Int

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
    }

    static let DIRS = [(-1, 0), (0, 1), (1, 0), (0, -1)]

    func part1() throws -> any CustomStringConvertible {
        let start = grid.indices.lazy.compactMap({ i in grid[i].firstIndex(of: "S").map({ (i, $0) }) }).first!
        let end = grid.indices.lazy.compactMap({ i in grid[i].firstIndex(of: "E").map({ (i, $0) }) }).first!

        var deposit = Array(repeating: Array(repeating: -1, count: m), count: n)
        var deposits = 0
        for i in 0..<n {
            for j in 0..<m where grid[i][j] == "@" {
                deposit[i][j] = deposits
                deposits += 1
            }
        }

        let mask_all = (1 << deposits) - 1

        struct State: Hashable {
            let i: Int
            let j: Int
            let d: Int
            let mask_collected: Int
        }

        var seen: Set<State> = []
        var q = Deque<(State, Int)>()

        for d in Day15.DIRS.indices {
            let state = State(i: start.0, j: start.1, d: d, mask_collected: 0)
            seen.insert(state)
            q.append((state, 0))
        }

        while let (state, dist) = q.popFirst() {
            if (state.i, state.j) == end && state.mask_collected == mask_all {
                return dist
            }

            for d in [(Day15.DIRS.count + state.d - 1) % Day15.DIRS.count,
                            state.d,
                           (state.d + 1) % Day15.DIRS.count
                          ] {
                let (to_i, to_j) = (state.i + Day15.DIRS[d].0, state.j + Day15.DIRS[d].1)
                if to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                    continue
                }
                if grid[to_i][to_j] == "#" {
                    continue
                }

                var mask_collected = state.mask_collected
                if deposit[to_i][to_j] != -1 {
                    mask_collected |= 1 << deposit[to_i][to_j]
                }

                let next = State(i: to_i, j: to_j, d: d, mask_collected: mask_collected)
                if seen.insert(next).inserted {
                    q.append((next, dist + 1))
                }
            }
        }

        return -1
    }

    func part2() throws -> any CustomStringConvertible {
        let start = grid.indices.lazy.compactMap({ i in grid[i].firstIndex(of: "S").map({ (i, $0) }) }).first!
        let end = grid.indices.lazy.compactMap({ i in grid[i].firstIndex(of: "E").map({ (i, $0) }) }).first!
        let target = 2026

        func index(_ i: Int, _ j: Int, _ d: Int, _ sulphur: Int) -> Int {
            ((i * m + j) * Day15.DIRS.count + d) * (target + 1) + sulphur
        }

        var seen = Array(repeating: false, count: n * m * Day15.DIRS.count * (target + 1))
        var q = Deque<(Int, Int, Int, Int, Int)>()

        for d in Day15.DIRS.indices {
            seen[index(start.0, start.1, d, 0)] = true
            q.append((start.0, start.1, d, 0, 0))
        }

        while let (i, j, d_ind, sulphur, dist) = q.popFirst() {
            if (i, j) == end && sulphur == target {
                return dist
            }

            for d in [(Day15.DIRS.count + d_ind - 1) % Day15.DIRS.count,
                            d_ind,
                           (d_ind + 1) % Day15.DIRS.count
                          ] {
                let (to_i, to_j) = (i + Day15.DIRS[d].0, j + Day15.DIRS[d].1)
                if to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                    continue
                }
                if grid[to_i][to_j] == "#" {
                    continue
                }

                let to_sulphur = min(target, sulphur + (grid[to_i][to_j] == "@" ? 1 : 0))
                let k = index(to_i, to_j, d, to_sulphur)
                if !seen[k] {
                    seen[k] = true
                    q.append((to_i, to_j, d, to_sulphur, dist + 1))
                }
            }
        }

        return -1
    }

    func part3() throws -> any CustomStringConvertible {
        let start = grid.indices.lazy.compactMap({ i in grid[i].firstIndex(of: "S").map({ (i, $0) }) }).first!
        let end = grid.indices.lazy.compactMap({ i in grid[i].firstIndex(of: "E").map({ (i, $0) }) }).first!
        let target = 202620262026

        func index(_ i: Int, _ j: Int, _ d: Int, _ sulphur: Int) -> Int {
            ((i * m + j) * Day15.DIRS.count + d) * (limit + 1) + sulphur
        }

        let limit = 5000
        var fastest = Array(repeating: Int.max, count: limit + 1)
        var seen = Array(repeating: false, count: n * m * Day15.DIRS.count * (limit + 1))
        var q = Deque<(Int, Int, Int, Int, Int)>()

        for d in Day15.DIRS.indices {
            seen[index(start.0, start.1, d, 0)] = true
            q.append((start.0, start.1, d, 0, 0))
        }

        while let (i, j, d_ind, sulphur, dist) = q.popFirst() {
            if (i, j) == end && fastest[sulphur] == .max {
                fastest[sulphur] = dist
            }

            for d in [(Day15.DIRS.count + d_ind - 1) % Day15.DIRS.count,
                      d_ind,
                      (d_ind + 1) % Day15.DIRS.count] {
                let (to_i, to_j) = (i + Day15.DIRS[d].0, j + Day15.DIRS[d].1)
                if to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                    continue
                }
                if grid[to_i][to_j] == "#" {
                    continue
                }

                let to_sulphur = sulphur + (grid[to_i][to_j] == "@" ? 1 : 0)
                if to_sulphur > limit {
                    continue
                }

                let k = index(to_i, to_j, d, to_sulphur)
                if !seen[k] {
                    seen[k] = true
                    q.append((to_i, to_j, d, to_sulphur, dist + 1))
                }
            }
        }

        let tail = (limit / 2)...limit
        for period in 1...(tail.count / 2) {
            let pairs = tail.dropLast(period).map({ (fastest[$0], fastest[$0 + period]) })
            guard let step = pairs.first(where: { $0.0 != .max && $0.1 != .max }).map({ $0.1 - $0.0 }) else {
                continue
            }
            let repeats = pairs.allSatisfy({ a, b in
                a == .max || b == .max ? a == b : b - a == step
            })
            if repeats {
                let x = limit - ((limit - target) % period + period) % period
                return fastest[x] == .max ? -1 : fastest[x] + (target - x) / period * step
            }
        }

        return -1
    }
}