@testable import LordOfTheWings
import XCTest

final class Day03Tests: XCTestCase {
    func testPart1Sample1() throws {
        let input = try testInput("day03-sample-1.txt")
        XCTAssertEqual(try Day03(input: input).part1().description, "1478")
    }

    func testPart1() throws {
        let input = try testInput("day03-part-1.txt")
        XCTAssertEqual(try Day03(input: input).part1().description, "13851")
    }

    func testPart2Sample2() throws {
        let input = try testInput("day03-sample-2.txt")
        XCTAssertEqual(try Day03(input: input).part2().description, "1161463")
    }

    func testPart2() throws {
        let input = try testInput("day03-part-2.txt")
        XCTAssertEqual(try Day03(input: input).part2().description, "20522955805")
    }

    func testPart3Sample3() throws {
        let input = try testInput("day03-sample-3.txt")
        XCTAssertEqual(try Day03(input: input).part3().description, "50987")
    }

    func testPart3() throws {
        let input = try testInput("day03-part-3.txt")
        XCTAssertEqual(try Day03(input: input).part3().description, "426783")
    }
}
