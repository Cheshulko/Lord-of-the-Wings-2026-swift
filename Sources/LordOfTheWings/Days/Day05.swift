import Collections

struct Day05: Solution {
    typealias Point = (i: Int, j: Int)
    typealias Grid = [[Character]]

    static let day = 5

    let n: Int
    let m: Int
    let grid: Grid

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
        assert(n % 2 == 1 && m % 2 == 1)
    }

    func solve(
        char_to_fill: Character, 
        neighbors_need: Int = 5,
        neighbors: [Character],  
        neighbors_forbidden: [Character] = [], 
        start_points: [Point], 
        steps: Int = .max, 
        grid: inout Grid) {
        var q = Deque<Point>()
        for (i, j) in start_points {
            grid[i][j] = char_to_fill
            q.append(Point(i, j))
        }

        var checked = Array(repeating: Array(repeating: -1, count: m), count: n)

        var step = 0
        while !q.isEmpty && step < steps {
            var to_set: [Point] = []

            while let (fi, fj) = q.popFirst() {
                for di in -1...1 {
                    for dj in -1...1 {
                        let (i, j) = (fi + di, fj + dj)
                        if i < 0 || i == n || j < 0 || j == m || checked[i][j] == step || grid[i][j] == char_to_fill {
                            continue
                        }
                        checked[i][j] = step
                        var blocked = false
                        var cnt = 0
                        for di in -1...1 {
                            for dj in -1...1 {
                                let (to_i, to_j) = (i + di, j + dj)
                                if (di == 0 && dj == 0) || to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                                    continue
                                }
                                if neighbors.contains(grid[to_i][to_j]) {
                                    cnt += 1
                                }
                                if neighbors_forbidden.contains(grid[to_i][to_j]) {
                                    blocked = true
                                }
                            }
                        }
                        if !blocked && cnt >= neighbors_need {
                            to_set.append(Point(i, j))
                        }
                    }
                }
            }

            for (i, j) in to_set {
                grid[i][j] = char_to_fill
            }
            q.append(contentsOf: to_set)
            step += 1
        }
    }

    func solve_island(_ island_init_points: [Point], grid: inout Grid) {
        solve(char_to_fill: "#", neighbors: ["#", "1"], start_points: island_init_points, grid: &grid)
    }

    func solve_water(_ water_init_points: [Point], grid: inout Grid) {
        solve(char_to_fill: "=", neighbors: ["="], start_points: water_init_points, grid: &grid)
    }

    func solve_trees(_ tree_init_points: [Point], grid: inout Grid) {
        solve(char_to_fill: "@", neighbors_need: 4, neighbors: ["@"], neighbors_forbidden: ["=", "0", "1"], 
            start_points: tree_init_points, steps: 2, grid: &grid)   
    }

    func init_water(grid: inout Grid) -> [Point] {
        var start_points: [Point] = []
        for i in 0..<n {
            for j in 0..<m where grid[i][j] == "#" {
                var water = false
                for di in -1...1 {
                    for dj in -1...1 where di != 0 || dj != 0 {
                        let (to_i, to_j) = (i + di, j + dj)
                        if to_i < 0 || to_i == n || to_j < 0 || to_j == m {
                            water = true
                            continue
                        }
                        if grid[to_i][to_j] != "#" {
                            water = true
                        }
                    }
                }
                if water {
                    start_points.append(Point(i, j))
                }
            }
        }

        return start_points
    }

    func init_trees(grid: inout Grid) -> [Point] { 
        var start_points: [Point] = []
        for i in 2..<n - 2 {
            for j in 2..<m - 2 {
                var tree = true
                for di in -2...2 {
                    for dj in -2...2 {
                        if abs(di) + abs(dj) == 4 {
                            continue
                        }
                        if grid[i + di][j + dj] != "#" && grid[i + di][j + dj] != "@" {
                            tree = false
                        }
                    }
                }
                if tree {
                    start_points.append(Point(i, j))
                }
            }
        }

        return start_points;
    }

    func part1() throws -> any CustomStringConvertible {
        var grid = self.grid

        let island_init_points = [Point(n / 2, m / 2)]
        solve_island(island_init_points, grid: &grid)

        return grid.map({ $0.filter({ $0 == "#" }).count }).reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        var grid = self.grid

        let island_init_points = [Point(n / 2, m / 2)]
        solve_island(island_init_points, grid: &grid)

        let water_init_points = init_water(grid: &grid)
        solve_water(water_init_points, grid: &grid)

        return grid.map({ $0.filter({ $0 == "=" }).count }).reduce(0, +)
    }

    func part3() throws -> any CustomStringConvertible {
        var grid = self.grid

        let island_init_points = [Point(n / 2, m / 2)]
        solve_island(island_init_points, grid: &grid)

        let water_init_points = init_water(grid: &grid)
        solve_water(water_init_points, grid: &grid)

        let tree_init_points = init_trees(grid: &grid)
        solve_trees(tree_init_points, grid: &grid)      
        
        return grid.map({ $0.filter({ $0 == "@" }).count }).reduce(0, +)
    }
}