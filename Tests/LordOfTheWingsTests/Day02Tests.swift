@testable import LordOfTheWings
import XCTest

final class Day02Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day02-sample-1.txt")
        XCTAssertEqual(try Day02(input: input).part1().description, "122157")
    }

    func testPart1() throws {
        let input = try testInput("day02-part-1.txt")
        XCTAssertEqual(try Day02(input: input).part1().description, "368808")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day02-sample-2.txt")
        XCTAssertEqual(try Day02(input: input).part2().description, "122157")
    }

    func testPart2() throws {
        let input = try testInput("day02-part-2.txt")
        XCTAssertEqual(try Day02(input: input).part2().description, "58403245383")
    }

    func testPart3Sample3() throws {
        let input = try testInput("day02-sample-3.txt")
        XCTAssertEqual(try Day02(input: input).part3().description, "122157")
    }

    func testPart3() throws {
        let input = try testInput("day02-part-3.txt")
        XCTAssertEqual(try Day02(input: input).part3().description, "581871133422")
    }
}
