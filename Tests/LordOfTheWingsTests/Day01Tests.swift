@testable import LordOfTheWings
import XCTest

final class Day01Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day01-sample-1.txt")
        XCTAssertEqual(try Day01(input: input).part1().description, "11")
    }

    func testPart1() throws {
        let input = try testInput("day01-part-1.txt")
        XCTAssertEqual(try Day01(input: input).part1().description, "1457")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day01-sample-1.txt")
        XCTAssertEqual(try Day01(input: input).part2().description, "9")
    }

    func testPart2() throws {
        let input = try testInput("day01-part-2.txt")
        XCTAssertEqual(try Day01(input: input).part2().description, "314")
    }

    func testPart3Sample1() throws {
        let input = try testInput("day01-sample-1.txt")
        XCTAssertEqual(try Day01(input: input).part3().description, "61")
    }

    func testPart3() throws {
        let input = try testInput("day01-part-3.txt")
        XCTAssertEqual(try Day01(input: input).part3().description, "643604")
    }
}
