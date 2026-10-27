protocol Solution {
    static var day: Int { get }

    init(input: String) throws

    func part1() throws -> any CustomStringConvertible
    func part2() throws -> any CustomStringConvertible
    func part3() throws -> any CustomStringConvertible
}

enum SolutionError: Error, CustomStringConvertible {
    case notImplemented(day: Int, part: Int)

    var description: String {
        switch self {
        case let .notImplemented(day, part):
            return "Day \(day) part \(part) is not implemented yet"
        }
    }
}
