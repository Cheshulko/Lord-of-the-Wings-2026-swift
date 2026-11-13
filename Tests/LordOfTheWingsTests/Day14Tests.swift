@testable import LordOfTheWings
import XCTest

final class Day14Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day14-sample-1.txt")
        XCTAssertEqual(try Day14(input: input).part1().description, "67")
    }

    func testPart1() throws {
        let input = try testInput("day14-part-1.txt")
        XCTAssertEqual(try Day14(input: input).part1().description, "283")
    }

    func testPart2Sample1() throws {
        let input = try testInput("day14-sample-1.txt")
        XCTAssertEqual(try Day14(input: input).part2().description, "12")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day14-sample-2.txt")
        XCTAssertEqual(try Day14(input: input).part2().description, "63")
    }

    func testPart2() throws {
        let input = try testInput("day14-part-2.txt")
        XCTAssertEqual(try Day14(input: input).part2().description, "439") 
    }

    func testPart3Sample1() throws {
        let input = try testInput("day14-sample-1.txt")
        XCTAssertEqual(try Day14(input: input).part3().description, "0")
    }

    func testPart3Sample2() throws {
        let input = try testInput("day14-sample-2.txt")
        XCTAssertEqual(try Day14(input: input).part3().description, "21")
    }

    func testPart3() throws {
        let input = try testInput("day14-part-3.txt")
        XCTAssertEqual(try Day14(input: input).part3().description, "1710")
    }
}
