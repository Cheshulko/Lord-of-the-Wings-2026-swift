import Collections

struct Day17: Solution {
    static let day = 17

    let grid: [[Character]]
    let n: Int
    let m: Int

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
    }

    func part1() throws -> any CustomStringConvertible {
        assert(grid[0][0] == "#")

        var q = Deque<(Int, Int)>()
        var dist = Array(repeating: Array(repeating: -1, count: m), count: n)

        q.append((0, 0))
        dist[0][0] = 0

        while let (i, j) = q.popFirst() {
            for (di, dj) in [(0, -1), (0, 1), (-1, 0), (1, 0)] {
                let (to_i, to_j) = (i + di, j + dj)
                if to_i < 0 || to_i == n || to_j < 0 || to_j == m || 
                    dist[to_i][to_j] != -1 || grid[to_i][to_j] != "#" {
                    continue
                }

                dist[to_i][to_j] = dist[i][j] + 1
                q.append((to_i, to_j))
            }
        }

        return dist[n - 1][m - 1]
    }

    func is_border(i: Int, j: Int, left: Bool) -> Bool {
        if left {
            if i != n && j - 1 < 0 && grid[i][j] == "#" {
                return true
            }
            if i != n && j == m && grid[i][j - 1] == "#" {
                return true
            }
            if i != n && j != m && j - 1 >= 0 && grid[i][j] != grid[i][j - 1] {
                return true
            }

            return false
        } else {
            if i - 1 < 0 && j != m && grid[i][j] == "#" {
                return true
            }
            if i == n && j != m && grid[i - 1][j] == "#" {
                return true
            }
            if i - 1 >= 0 && i != n && j != m && grid[i][j] != grid[i - 1][j]{
                return true
            }

            return false
        }
    }

    func part2() throws -> any CustomStringConvertible {
        var cnt = 0

        for i in 0...n {
            for j in 0...m {
                if is_border(i: i, j: j, left: false) {
                    cnt += 1
                }
                if is_border(i: i, j: j, left: true) {
                    cnt += 1
                }
            }
        }

        return cnt
    }

    func part3() throws -> any CustomStringConvertible {
        let moves = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        func follows(_ i: Int, _ j: Int, _ d: Int) -> Bool {
            let (to_i, to_j) = (i + moves[d].0, j + moves[d].1)
            if to_i < 0 || to_i > n || to_j < 0 || to_j > m {
                return false
            }
            return is_border(i: min(i, to_i), j: min(j, to_j), left: d % 2 == 1)
        }

        var (i, j, d) = (0, 0, 3)
        var steps = 0
        var to_end = 0
        repeat {
            d = [1, 0, 3].map({ (d + $0) % 4 }).first(where: { follows(i, j, $0) })!
            i += moves[d].0
            j += moves[d].1
            steps += 1
            if (i, j) == (n, m) {
                to_end = steps
            }
        } while (i, j) != (0, 0)

        return min(to_end, steps - to_end)
    }
}