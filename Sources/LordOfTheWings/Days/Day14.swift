import Collections

struct DSU {
    private var parents: [Int]
    private(set) var ranks: [Int]

    init(size: Int) {
        parents = Array(0..<size)
        ranks = Array(repeating: 1, count: size)
    }

    mutating func find(_ x: Int) -> Int {
        if x != parents[x] {
            parents[x] = find(parents[x])
        }

        return parents[x]
    }

    mutating func same(_ x: Int, _ y: Int) -> Bool {
        find(x) == find(y)
    }

    @discardableResult
    mutating func union(_ x: Int, _ y: Int) -> Bool {
        var x = find(x)
        var y = find(y)

        if x == y {
            return false
        }

        if ranks[x] < ranks[y] {
            swap(&x, &y)
        }

        parents[y] = x
        ranks[x] += ranks[y]

        return true
    }
}

struct Day14: Solution {
    static let day = 14

    let grid: [[Character]]
    let n: Int
    let m: Int

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
    }

    struct Edge: Hashable {
        let a: Int
        let b: Int

        init(_ a: Int, _ b: Int) {
            self.a = min(a, b)
            self.b = max(a, b)
        }
    }

    func graph() -> (pieces: Int, edges: [Edge: Int]) {
        var groups = Array(repeating: Array(repeating: -1, count: m), count: n)

        func dfs(ind: Int, i: Int, j: Int, groups: inout [[Int]]) {
            groups[i][j] = ind

            for (di, dj) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                let to_i = i + di
                let to_j = j + dj
                if to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                    continue
                }
                if groups[to_i][to_j] != -1 {
                    continue
                }

                if grid[i][j] == grid[to_i][to_j] {
                    dfs(ind: ind, i: to_i, j: to_j, groups: &groups)
                }
            }
        }

        var ind = 0
        for i in 0..<n {
            for j in 0..<m {
                if groups[i][j] == -1 {
                    dfs(ind: ind, i: i, j: j, groups: &groups)
                    ind += 1
                }
            }
        }

        func connections(_ groups: [[Int]], out_of_the_field: Int) -> [Edge: Int] {
            func group(_ i: Int, _ j: Int) -> Int {
                i < 0 || i == n || j < 0 || j == m ? out_of_the_field : groups[i][j]
            }

            var lengths: [Edge: Int] = [:]
            for i in 0...n {
                for j in 0...m {
                    if group(i - 1, j) != group(i, j) {
                        lengths[Edge(group(i - 1, j), group(i, j)), default: 0] += 1
                    }
                    if group(i, j - 1) != group(i, j) {
                        lengths[Edge(group(i, j - 1), group(i, j)), default: 0] += 1
                    }
                }
            }

            return lengths
        }

        return (ind, connections(groups, out_of_the_field: ind))
    }

    func spanning_tree(pieces: Int, edges: [Edge: Int]) -> [(edge: Edge, weight: Int)] {
        var dsu = DSU(size: pieces + 1)
        var tree: [(edge: Edge, weight: Int)] = []
        for (edge, weight) in edges.sorted(by: { $0.value < $1.value }) where dsu.union(edge.a, edge.b) {
            tree.append((edge, weight))
        }

        return tree
    }

    func part1() throws -> any CustomStringConvertible {
        var count = 0
        for i in 0..<n {
            for j in 0..<m {
                for (di, dj) in [(-1, 0), (1, 0), (0, -1), (0, 1)] {
                    let to_i = i + di
                    let to_j = j + dj
                    if to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                        count += 2
                        continue
                    }
                    
                    if grid[i][j] != grid[to_i][to_j] {
                        count += 1
                    }
                }

            }
        } 

        return count / 2
    }

    func part2() throws -> any CustomStringConvertible {
        let (pieces, edges) = graph()

        return spanning_tree(pieces: pieces, edges: edges).map({ $0.weight }).reduce(0, +)
    }

    func part3() throws -> any CustomStringConvertible {
        let (pieces, edges) = graph()
        let tree = spanning_tree(pieces: pieces, edges: edges)

        var neighbours = Array(repeating: [Int](), count: pieces + 1)
        for edge in edges.keys {
            neighbours[edge.a].append(edge.b)
            neighbours[edge.b].append(edge.a)
        }

        var best = Int.max
        for p in 0..<pieces {
            for q in p..<pieces {
                var dsu = DSU(size: pieces + 1)
                for v in neighbours[p] {
                    dsu.union(p, v) 
                }
                for v in neighbours[q] {
                    dsu.union(q, v) 
                }

                var total = 0
                for (edge, weight) in tree where dsu.union(edge.a, edge.b) {
                    total += weight
                }
                best = min(best, total)
            }
        }

        return best
    }
}