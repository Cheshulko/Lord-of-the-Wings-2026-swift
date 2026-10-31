@testable import LordOfTheWings
import XCTest

final class Day05Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day05-sample-1.txt")
        XCTAssertEqual(try Day05(input: input).part1().description, "137")
    }

    func testPart1() throws {
        let input = try testInput("day05-part-1.txt")
        XCTAssertEqual(try Day05(input: input).part1().description, "1077")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day05-sample-2.txt")
        XCTAssertEqual(try Day05(input: input).part2().description, "69")
    }

    func testPart2() throws {
        let input = try testInput("day05-part-2.txt")
        XCTAssertEqual(try Day05(input: input).part2().description, "1289")
    }

    func testPart3Sample3() throws {
        let input = try testInput("day05-sample-3.txt")
        XCTAssertEqual(try Day05(input: input).part3().description, "14")
    }

    func testPart3() throws {
        let input = try testInput("day05-part-3.txt")
        XCTAssertEqual(try Day05(input: input).part3().description, "9435")
    }
}
