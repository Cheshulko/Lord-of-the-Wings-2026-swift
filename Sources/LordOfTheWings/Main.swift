import ArgumentParser
import Foundation

@main
struct Main: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "LordOfTheWings",
        discussion: "Example: LordOfTheWings --day=1 --part=2 --input=Inputs/day01-part-2.txt"
    )

    enum Part: String, ExpressibleByArgument, CaseIterable {
        case one = "1", two = "2", three = "3", all
    }

    @Option(help: "The day to run (1-20).")
    var day: Int

    @Option(help: "Which part to run: 1, 2, 3 or all.")
    var part: Part = .all

    @Option(help: "Path to the puzzle input.")
    var input: String

    func validate() throws {
        guard Registry.solution(for: day) != nil else {
            let available = Registry.all.map { String($0.day) }.joined(separator: ", ")
            throw ValidationError("Day \(day) is not implemented yet. Available days: \(available).")
        }
    }

    func run() throws {
        let solutionType = Registry.solution(for: day)!
        let text = try readInput()

        let clock = ContinuousClock()
        var start = clock.now
        let solution = try solutionType.init(input: text)
        print("Parse: \(format(clock.now - start))")

        let parts: [Int] = switch part {
        case .one: [1]
        case .two: [2]
        case .three: [3]
        case .all: [1, 2, 3]
        }

        for number in parts {
            start = clock.now
            let answer = try switch number {
            case 1: solution.part1()
            case 2: solution.part2()
            default: solution.part3()
            }
            print("Day \(day) part \(number): \(answer)  (\(format(clock.now - start)))")
        }
    }

    private func readInput() throws -> String {
        guard FileManager.default.fileExists(atPath: input) else {
            throw ValidationError("Input file not found: \(input)")
        }
        return try String(contentsOfFile: input, encoding: .utf8)
    }

    private func format(_ duration: Duration) -> String {
        let (seconds, attoseconds) = duration.components
        let millis = attoseconds / 1_000_000_000_000_000
        return String(format: "%lld.%03lld", seconds, millis)
    }
}
