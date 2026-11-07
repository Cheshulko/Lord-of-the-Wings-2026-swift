@testable import LordOfTheWings
import XCTest

final class Day10Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day10-sample-1.txt")
        XCTAssertEqual(try Day10(input: input).part1().description, "29")
    }

    func testPart1() throws {
        let input = try testInput("day10-part-1.txt")
        XCTAssertEqual(try Day10(input: input).part1().description, "60")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day10-sample-1.txt")
        XCTAssertEqual(try Day10(input: input).part2().description, "50000")
    }

    func testPart2() throws {
        let input = try testInput("day10-part-2.txt")
        XCTAssertEqual(try Day10(input: input).part2().description, "127011") 
    }

    func testPart3Sample2() throws {
        let input = try testInput("day10-sample-2.txt")
        XCTAssertEqual(try Day10(input: input).part3().description, "13314695352588")
    }

    func testPart3() throws {
        let input = try testInput("day10-part-3.txt")
        XCTAssertEqual(try Day10(input: input).part3().description, "7595352152361")
    }
}
