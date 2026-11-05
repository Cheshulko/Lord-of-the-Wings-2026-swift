struct Day08: Solution {
    static let day = 8

    let grid: [[Character]]
    let n: Int
    let m: Int

    init(input: String) {
        grid = input.lines.map(Array.init)
        n = grid.count
        m = grid[0].count
    }

    func value(ch: Character) -> Int? {
        if let c = ch.wholeNumberValue {
            return c
        }

        switch ch {
            case "d": return -3;
            case "c": return -2  
            case "b": return -1
            case "a": return 0
            default: return nil
        }
    }

    func inc(ch: Int) -> Character {
        let to = ch + 1

        switch to {
            case -2: return "c"
            case -1: return "b"
            case 0: return "a"
            case 10: return "c"
            default: return Character(String(to))
        } 
    }

    func trace(_ row: Int, _ col: Int, _ dr: Int, _ dc: Int, grid: inout [[Character]], grow: Bool = false) -> (energy: Int, grows: Int?) {
        var energy = 0
        var cur = 0
        var cnt = 0

        var i = row, j = col
        while i >= 0 && i < n && j >= 0 && j < m {
            if let h = value(ch: grid[i][j]) {
                if h > cur {
                    energy += 1
                }
                if grow && (h > cur || h <= 0) {
                    let next = inc(ch: h) 
                    grid[i][j] = next
                    if next == "c" {
                        cnt += 1
                    }
                }
                cur = max(cur, h)
            }
            
            cur = max(0, cur - 1)
            i += dr
            j += dc
        }

        return (energy, cnt)
    }

    func solveDirs(grid: inout [[Character]], dirs: [(dr: Int, dc: Int)], grow: Bool = false) -> (energy: Int, grows: Int) {
        var energy = 0
        var grows = 0

        for (dr, dc) in dirs {
            var dir_energy = 0
            for row in 0..<n {
                for col in 0..<m where grid[row][col] != "."{
                    if row - dr >= 0 && row - dr < n &&
                        col - dc >= 0 && col - dc < m && 
                        grid[row - dr][col - dc] != "." {
                        continue
                    }

                    let trace = trace(row, col, dr, dc, grid: &grid, grow: grow)
                    dir_energy += trace.energy
                    grows += trace.grows ?? 0
                }
            }
            energy += dir_energy
        }

        return (energy, grows)
    }

    static let DIRS = [
        (dr: 1, dc: 1),
        (dr: 1, dc: -1),
        (dr: 0, dc: -2),
        (dr: -1, dc: -1),
        (dr: -1, dc: 1),
        (dr: 0, dc: 2),
    ]

    func part1() throws -> any CustomStringConvertible {
        var grid = self.grid

        return solveDirs(grid: &grid, dirs: [Day08.DIRS[0]]).energy
    }    

    func part2() throws -> any CustomStringConvertible {
        var grid = self.grid

        return solveDirs(grid: &grid, dirs: Day08.DIRS).energy
    }

    func part3() throws -> any CustomStringConvertible {
        let ARMY = 100000

        var grid = self.grid
        var energy = 0
        var out = 0
        var have = 0
        while have < ARMY {
            let (dr, dc) = Day08.DIRS[out]
            var dir_energy = 0
            for row in 0..<n {
                for col in 0..<m where grid[row][col] != "." {
                    if row - dr >= 0 && row - dr < n &&
                        col - dc >= 0 && col - dc < m &&
                        grid[row - dr][col - dc] != "." {
                        continue
                    }

                    let trace = trace(row, col, dr, dc, grid: &grid, grow: true)
                    dir_energy += trace.energy
                    have += trace.grows ?? 0
                }
            }

            energy += dir_energy
            out += 1
            out %= Day08.DIRS.count
        }

        return energy
    }
}