@testable import LordOfTheWings
import XCTest

final class Day06Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day06-sample-1.txt")
        XCTAssertEqual(try Day06(input: input).part1().description, "7")
    }

    func testPart1() throws {
        let input = try testInput("day06-part-1.txt")
        XCTAssertEqual(try Day06(input: input).part1().description, "45")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day06-sample-1.txt")
        XCTAssertEqual(try Day06(input: input).part2().description, "6")
    }

    func testPart2() throws {
        let input = try testInput("day06-part-2.txt")
        XCTAssertEqual(try Day06(input: input).part2().description, "815") 
    }

    func testPart3Sample2() throws {
        let input = try testInput("day06-sample-2.txt")
        XCTAssertEqual(try Day06(input: input).part3().description, "3")
    }

    func testPart3() throws {
        let input = try testInput("day06-part-3.txt")
        XCTAssertEqual(try Day06(input: input).part3().description, "1660")
    }
}
