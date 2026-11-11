struct Day12: Solution {
    static let day = 12

    let n: Int
    let m: Int
    let grid: [[Character]]

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
    }

    func solve() -> Int {
        var horId = Array(repeating: Array(repeating: -1, count: m), count: n)
        var verId = Array(repeating: Array(repeating: -1, count: m), count: n)
        var horCount = 0
        var verCount = 0

        for i in 0..<n {
            for j in 0..<m where grid[i][j] == "#" {
                if j > 0 && grid[i][j - 1] == "#" {
                    horId[i][j] = horId[i][j - 1]
                } else {
                    horId[i][j] = horCount
                    horCount += 1
                }
                if i > 0 && grid[i - 1][j] == "#" {
                    verId[i][j] = verId[i - 1][j]
                } else {
                    verId[i][j] = verCount
                    verCount += 1
                }
            }
        }

        var adj = Array(repeating: [Int](), count: horCount)
        for i in 0..<n {
            for j in 0..<m where grid[i][j] == "#" {
                adj[horId[i][j]].append(verId[i][j])
            }
        }

        return kuhn(adj: adj, rightCount: verCount)
    }
    
    func kuhn(adj: [[Int]], rightCount: Int) -> Int {
        var matchRight = Array(repeating: -1, count: rightCount)
        var used = Array(repeating: false, count: rightCount)

        func dfs(_ l: Int) -> Bool {
            for r in adj[l] where !used[r] {
                used[r] = true
                if matchRight[r] == -1 || dfs(matchRight[r]) {
                    matchRight[r] = l
                    return true
                }
            }
            return false
        }

        var matching = 0
        for l in 0..<adj.count {
            for r in 0..<rightCount { used[r] = false }
            if dfs(l) {
                matching += 1
            }
        }

        return matching
    }

    func part1() throws -> any CustomStringConvertible {
        return solve()
    }

    func part2() throws -> any CustomStringConvertible {
        return solve()
    }

    func part3() throws -> any CustomStringConvertible {
        return solve()
    }
}