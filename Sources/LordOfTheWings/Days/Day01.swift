struct Day01: Solution {
    static let day = 1

    let numbers: [Int]

    init(input: String) {
        numbers = input.split(separator: ",")
            .compactMap { Int($0) }
            .sorted()
    }

    func solve(start: Int, step: Int, fn: (Int) -> Int) -> Int {
        var sum = 0
        var side = start
        for num in numbers {
            var need = fn(side)
            while need < num {
                side += step
                need = fn(side)
            }
            sum += need - num
        }

        return sum
    }

    func part1() throws -> any CustomStringConvertible {
        solve(start: 1, step: 1, fn: {$0 * $0})
    }

    func part2() throws -> any CustomStringConvertible {
        solve(start: 2, step: 1, fn: {4 * $0})
    }

    func part3() throws -> any CustomStringConvertible {
        solve(start: 3, step: 2, fn: {$0 * $0 - 1})
    }
}
