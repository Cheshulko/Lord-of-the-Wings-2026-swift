@testable import LordOfTheWings
import XCTest

final class Day18Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day18-sample-1.txt")
        XCTAssertEqual(try Day18(input: input).part1().description, "96")
    }

    func testPart1() throws {
        let input = try testInput("day18-part-1.txt")
        XCTAssertEqual(try Day18(input: input).part1().description, "840")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day18-sample-2.txt")
        XCTAssertEqual(try Day18(input: input).part2().description, "205")
    }

    func testPart2() throws {
        let input = try testInput("day18-part-2.txt")
        XCTAssertEqual(try Day18(input: input).part2().description, "2342676") 
    }

    func testPart3() throws {
        let input = try testInput("day18-part-3.txt")
        XCTAssertEqual(try Day18(input: input).part3().description, "934707195384589")
    }
}
