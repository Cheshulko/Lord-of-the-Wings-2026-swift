@testable import LordOfTheWings
import XCTest

final class Day04Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day04-sample-1.txt")
        XCTAssertEqual(try Day04(input: input).part1().description, "27598")
    }

    func testPart1() throws {
        let input = try testInput("day04-part-1.txt")
        XCTAssertEqual(try Day04(input: input).part1().description, "176673")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day04-sample-2.txt")
        XCTAssertEqual(try Day04(input: input).part2().description, "6470")
    }

    func testPart2() throws {
        let input = try testInput("day04-part-2.txt")
        XCTAssertEqual(try Day04(input: input).part2().description, "605281630")
    }

    func testPart3Sample3() throws {
        let input = try testInput("day04-sample-3.txt")
        XCTAssertEqual(try Day04(input: input).part3().description, "2998")
    }

    func testPart3Sample4() throws {
        let input = try testInput("day04-sample-4.txt")
        XCTAssertEqual(try Day04(input: input).part3().description, "3004")
    }

    func testPart3() throws {
        let input = try testInput("day04-part-3.txt")
        XCTAssertEqual(try Day04(input: input).part3().description, "6785478")
    }
}
