struct Day02: Solution {
    static let day = 2

    let groups: [[(harder: Int, softer: Int)]]

    init(input: String) {
        groups = input.lines.map({ line in 
            line.split(whereSeparator: \.isWhitespace).map({ pair -> (harder: Int, softer: Int) in 
                let isGreater = pair.contains(">")
                let parts = pair.split(separator: isGreater ? ">" : "<")

                return isGreater ? 
                    (harder: Int(parts[0])!, softer: Int(parts[1])!) : 
                    (harder: Int(parts[1])!, softer: Int(parts[0])!) 
            })
        })
    }

    func solve(group: [(harder: Int, softer: Int)]) -> Int {
        let maxValue = groups
            .joined()
            .reduce(0, { max($0, $1.0, $1.1) })

        let minValue = groups
            .joined()
            .reduce(maxValue, { min($0, $1.0, $1.1) })

        var grid = Array(repeating: Array(repeating: false, count: maxValue + 1), count: maxValue + 1)
        for (harder, softer) in group {
            grid[harder][softer] = true;
        }

        // Floyd–Warshall
        for k in minValue...maxValue {
            for i in minValue...maxValue {
                for j in minValue...maxValue {
                    if grid[i][k] && grid[k][j] {
                        grid[i][j] = true
                    }
                }
            }
        }

        let power = grid.map({ $0.filter({ $0 }).count })

        return (minValue...maxValue)
                    .sorted(by: { power[$0] > power[$1] })
                    .reduce(0, { 10 * $0 + $1 })
    }

    func part1() throws -> any CustomStringConvertible {
        return groups.lazy.map(solve).reduce(0, +)
    }

    func part2() throws -> any CustomStringConvertible {
        try part1()
    }

    func part3() throws -> any CustomStringConvertible {
        try part1()
    }
}
